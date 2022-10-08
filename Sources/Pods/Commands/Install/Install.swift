//
//  Install.swift
//  Pods
//
//  Created by Vyacheslav Khorkov on 05.11.2021.
//  Copyright © 2021 Vyacheslav Khorkov. All rights reserved.
//

import ArgumentParser
import Foundation

struct Install: ParsableCommand {
    @Flag(name: .shortAndLong, help: "Suppress command output.") var quiet = false
    @Flag(name: .long, inversion: .prefixedNo, help: "Play bell sound on finish.") var bell = true

    static var configuration: CommandConfiguration = .init(
        abstract: """
        Using \("pod install".yellow) in a more convenient way.
        • Automagically adding prefix \("bundle exec".yellow) if bundler env found;
        • Handling bundler \("missing gems".yellow) error;
        • Handling cocoapods \("out-of-date source repos".yellow) error;
        • Output fancy log and animations;
        • Playing bell sound in the end.
        """
    )

    mutating func run() throws {
        try WrappedError.wrap(playBell: bell) {
            try wrappedRun()
        }
    }

    private func wrappedRun() throws {
        var tries = 3
        var handledErrorCodes: Set<Int> = []
        let useBundler = FileManager.containsUpToRoot(file: "Gemfile")
        while tries > 0 {
            do {
                return try runCommand("pod install", quietArg: "--silent", useBundler: useBundler)
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
        case 7, 11: // https://github.com/rubygems/bundler/blob/master/lib/bundler/errors.rb#L35
            print("🚑 Missing gems. Let's try ".yellow + "`bundle install`".yellow)
            try runCommand("bundle install", quietArg: "--quiet")
            return true
        case 31, 1: // https://github.com/CocoaPods/CocoaPods/blob/master/lib/cocoapods/command/install.rb#L25
            // Yeah, it's dangerous to handle error code 1 in that way. But let's try.
            print("🚑 Out-of-date source repos. Let's try ".yellow + "`pod repo update`".yellow)
            try runCommand("pod repo update", quietArg: "--silent", useBundler: useBundler)
            return true
        default:
            print("🚑 Unknown error code.".yellow)
            return false
        }
    }

    private func runCommand(_ command: String, quietArg: String, useBundler: Bool = false) throws {
        var command = useBundler ? "bundle exec " + command : command
        let commandOutput = command
        command += quiet ? " " + quietArg : ""
        let printer = PodsPrinter(title: "\(Pods.logo) \(commandOutput)", verbose: !quiet)
        if quiet {
            try printer.spinner("\(Pods.logo) \(commandOutput.green)") {
                try shell("BUNDLER_FORCE_TTY=1 " + command)
            }
        } else {
            printer.print("⏰")
            do {
                try printShell(command)
                printer.done()
            } catch {
                printer.print("✕".red)
                throw error
            }
        }
    }
}
