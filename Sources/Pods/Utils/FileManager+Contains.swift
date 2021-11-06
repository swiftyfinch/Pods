//
//  FileManager+Contains.swift
//  Pods
//
//  Created by Vyacheslav Khorkov on 06.11.2021.
//  Copyright © 2021 Vyacheslav Khorkov. All rights reserved.
//

import Foundation

extension FileManager {
    static func contains(file: String) -> Bool {
        let manager = self.default
        let current = manager.currentDirectoryPath
        return manager.fileExists(atPath: current.appending("/" + file))
    }
}
