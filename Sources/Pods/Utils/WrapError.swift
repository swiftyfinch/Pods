//
//  WrapError.swift
//  Pods
//
//  Created by Vyacheslav Khorkov on 05.11.2021.
//  Copyright © 2021 Vyacheslav Khorkov. All rights reserved.
//

import Foundation
import Rainbow

enum WrappedError: Error, LocalizedError {
    case common(String)

    var errorDescription: String? {
        switch self {
        case .common(let description):
            // Need to clear color because in _errorLabel we don't do that
            return """
            \u{1B}[0m\(description)
            """
        }
    }

    static func wrap(playBell: Bool, block: () throws -> Void) throws {
        defer {
            if playBell { playBellSound() }
        }

        do {
            try block()
        } catch {
            throw WrappedError.common(error.localizedDescription.red)
        }
    }
}
