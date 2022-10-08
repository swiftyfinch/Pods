//
//  FileManager+Contains.swift
//  Pods
//
//  Created by Vyacheslav Khorkov on 06.11.2021.
//  Copyright © 2021 Vyacheslav Khorkov. All rights reserved.
//

import Foundation

extension FileManager {
    static func containsUpToRoot(file: String) -> Bool {
        let manager = self.default
        var current = manager.currentDirectoryPath
        repeat {
            if manager.fileExists(atPath: current.appending("/\(file)")) { return true }
            current.append("/..")
        } while current != "/"
        return false
    }
}
