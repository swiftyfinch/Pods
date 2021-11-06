//
//  Install.swift
//  Pods
//
//  Created by Vyacheslav Khorkov on 05.11.2021.
//  Copyright © 2021 Vyacheslav Khorkov. All rights reserved.
//

import ArgumentParser
import Files
import Foundation

struct Install: ParsableCommand {
    @Flag(name: .shortAndLong, help: "Suppress output.") var quiet = false
    @Flag(name: .long, inversion: .prefixedNo, help: "Play bell sound on finish.") var bell = true

    mutating func run() throws {
        try WrappedError.wrap(playBell: bell) {
            try wrappedRun()
        }
    }

    private func wrappedRun() throws {
        var tries = 2
        var handledErrorCodes: Set<Int> = []
        let useBundler = Folder.current.containsFile(at: "Gemfile")
        while tries > 0 {
            do {
                return try runCommand("pod install\(quiet ? " --silent" : "")", useBundler: useBundler)
            } catch let error as ErrorCodeProvidable {
                do {
                    try handle(error: error,
                               handledErrorCodes: &handledErrorCodes,
                               useBundler: useBundler)
                } catch {
                    // Don't duplicate error output in none quiet mode
                    guard !quiet else { throw error }
                    abort()
                }
            }
            tries -= 1
        }
    }

    private func handle(error: ErrorCodeProvidable,
                        handledErrorCodes: inout Set<Int>,
                        useBundler: Bool) throws {
        // If we get the same error code again stop trying
        if handledErrorCodes.contains(error.errorCode) { throw error }

        // Throw error back if can't handle error code
        if !(try handle(errorCode: error.errorCode, useBundler: useBundler)) { throw error }

        handledErrorCodes.insert(error.errorCode)
    }

    private func handle(errorCode: Int, useBundler: Bool) throws -> Bool {
        switch errorCode {
        case 7:
            print("🚑 Missing gems. Let's try ".yellow + "`bundle install`".yellow)
            try runCommand("bundle install\(quiet ? " --quiet" : "")")
            return true
        case 31:
            print("🚑 Out-of-date source repos. Let's try ".yellow + "`pod repo update`".yellow)
            try runCommand("pod repo update\(quiet ? " --silent" : "")", useBundler: useBundler)
            return true
        default:
            print("🚑 Unknown error code.".yellow)
            return false
        }
    }

    private func runCommand(_ command: String, useBundler: Bool = false) throws {
        let command = useBundler ? "bundle exec " + command : command
        let printer = PodsPrinter(title: "🌱 " + command, verbose: !quiet)
        if quiet {
            try printer.spinner("🌱 " + command.yellow) {
                try shell("BUNDLER_FORCE_TTY=1 " + command)
            }
        } else {
            printer.print("⏱")
            do {
                try printShell(command)
                printer.done()
            } catch {
                printer.print("✕")
                throw error
            }
        }
    }
}
