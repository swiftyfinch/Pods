//
//  PodsPrinter.swift
//  Rugby
//
//  Created by Vyacheslav Khorkov on 09.01.2021.
//  Copyright © 2021 Vyacheslav Khorkov. All rights reserved.
//

import Files
import Foundation

struct PodsPrinter: Printer {
    private let begin = ProcessInfo.processInfo.systemUptime
    private let formatter: Formatter
    private let printers: [Printer]

    init(formatter: Formatter, printers: [Printer]) {
        self.formatter = formatter
        self.printers = printers
    }

    func print(_ value: String, level: Int) {
        printers.forEach {
            $0.print(formatter.format(text: value, chop: $0.chop), level: level)
        }
    }

    func done() {
        let time = ProcessInfo.processInfo.systemUptime - begin
        printers.forEach {
            let value = formatter.format(text: "✓", time: time.output(), chop: $0.chop)
            $0.print(value)
            $0.done()
        }
    }
}

extension PodsPrinter {
    init(title: String? = nil, verbose: Bool) {
        let printers: [Printer] = [verbose ? DefaultPrinter(verbose: 1) : OneLinePrinter()]
        self.init(formatter: PodsFormatter(title: title), printers: printers)
    }
}
