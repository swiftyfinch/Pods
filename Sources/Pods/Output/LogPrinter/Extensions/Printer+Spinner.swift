//
//  Printer+Spinner.swift
//  Pods
//
//  Created by Vyacheslav Khorkov on 06.11.2021.
//  Copyright © 2021 Vyacheslav Khorkov. All rights reserved.
//

extension Printer {
    @discardableResult
    func spinner<Result>(_ text: String, job: @escaping () throws -> Result) rethrows -> Result {
        do {
            let result = try Spinner().show(text: text, job)
            done()
            return result
        } catch {
            print("✕".red)
            throw error
        }
    }
}
