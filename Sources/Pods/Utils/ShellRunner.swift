//
//  ShellRunner.swift
//  Pods
//
//  Created by Vyacheslav Khorkov on 05.11.2021.
//  Copyright © 2021 Vyacheslav Khorkov. All rights reserved.
//

import Foundation
import SwiftShell

@discardableResult
func shell(_ command: String, args: Any ...) throws -> String {
    try ShellRunner.shared.run(command, args: args)
}

func printShell(_ command: String, args: Any ...) throws {
    try ShellRunner.shared.runAndPrint(command, args: args)
}

// MARK: - Implementation

extension ShellRunner {
    fileprivate func runAndPrint(_ command: String, args: Any ...) throws {
        let commandWithArgs = combine(command: command, args: args)
        let currentShell = try getCurrentShell()
        let asyncCommand = SwiftShell.runAsyncAndPrint(currentShell, "-c", commandWithArgs)
        ProcessMonitor.shared.addProcess(asyncCommand)
        try asyncCommand.finish()
    }

    fileprivate func run(_ command: String, args: Any ...) throws -> String {
        let commandWithArgs = combine(command: command, args: args)
        let currentShell = try getCurrentShell()
        let asyncCommand = SwiftShell.runAsync(currentShell, "-c", commandWithArgs)
        ProcessMonitor.shared.addProcess(asyncCommand)

        var stdout: String?
        var stderror: String?
        do {
            // Workaround: https://github.com/kareman/SwiftShell/issues/52
            let readOutStreams = DispatchWorkItem {
                stdout = asyncCommand.stdout.read()
            }
            let readErrorStreams = DispatchWorkItem {
                stderror = asyncCommand.stderror.read()
            }
            DispatchQueue.global().async(execute: readOutStreams)
            DispatchQueue.global().async(execute: readErrorStreams)

            try asyncCommand.finish()
            readOutStreams.wait()
            readErrorStreams.wait()
            return stdout ?? ""
        } catch let error as CommandError {
            let output = [stdout, stderror]
                .compactMap { $0 }
                .joined(separator: "\n")
                .cleanUpOutput()
            throw ShellError.common(output, errorCode: error.errorcode)
        }
    }
}

// MARK: - Error Handling

protocol ErrorCodeProvidable: Error {
    var errorCode: Int { get }
}

extension CommandError: ErrorCodeProvidable {
    var errorCode: Int { errorcode }
}

enum ShellError: Swift.Error, LocalizedError, ErrorCodeProvidable {
    case common(String, errorCode: Int)

    var errorCode: Int {
        switch self {
        case .common(_, let errorCode):
            return errorCode
        }
    }

    var errorDescription: String? {
        switch self {
        case .common(let stderror, _):
            return stderror
        }
    }
}

final class ShellRunner {
    static let shared = ShellRunner()
    private var shell: String?

    private init() {}

    private func getCurrentShell() throws -> String {
        if let shell = shell { return shell }

        let output = SwiftShell.run(bash: "echo $SHELL")
        if output.succeeded {
            shell = output.stdout
            return output.stdout
        } else {
            throw wrapError(output)
        }
    }

    private func combine(command: String, args: Any ...) -> String {
        let stringArgs = args.flatten().map(String.init(describing:))
        return command + " " + stringArgs.joined(separator: " ")
    }

    // MARK: - Wrap Errors

    private func wrapError(_ output: RunOutput) -> Error {
        ShellError.common(output.stdout.cleanUpOutput(), errorCode: output.exitcode)
    }

    private func wrapError(_ command: AsyncCommand) -> Error {
        ShellError.common(command.stderror.read().cleanUpOutput(), errorCode: command.exitcode())
    }
}

// MARK: - Utils

private extension String {
    func cleanUpOutput() -> String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

private extension Array where Element: Any {
    func flatten() -> [Any] {
        flatMap { x -> [Any] in
            if let anyarray = x as? [Any] {
                return anyarray.map { $0 as Any }.flatten()
            }
            return [x]
        }
    }
}
