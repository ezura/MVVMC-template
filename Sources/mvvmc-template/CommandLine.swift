//
//  CommandLine.swift
//  MVVMC-template
//
//  Created by yuka ezura on 2019/02/23.
//

import Foundation

enum OutputStreamType {
    case stdin
    case stderr
}

extension CommandLine {
    static func print(_ message: String, outputStream: OutputStreamType = .stdin) {
        switch outputStream {
        case .stdin:
            Swift.print(message)
        case .stderr:
            fputs(message, stderr)
        }
    }
}
