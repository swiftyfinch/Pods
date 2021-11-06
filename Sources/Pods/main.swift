//
//  main.swift
//  Pods
//
//  Created by Vyacheslav Khorkov on 05.11.2021.
//  Copyright © 2021 Vyacheslav Khorkov. All rights reserved.
//

import ArgumentParser

struct Pods: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: """
        🌱 Cozy pod install
        📖 \("https://github.com/swiftyfinch/Pods".cyan) (⌘ + double click on link)
        """,
        version: "0.1",
        subcommands: [Install.self],
        defaultSubcommand: Install.self
    )
}

ProcessMonitor.sync()
Pods.main()
