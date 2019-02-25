//
//  Usage.swift
//  MVVMC-template
//
//  Created by ezura on 2019/02/23.
//

import Foundation

enum Usage {
    static func print() {
        let executableName = (CommandLine.arguments[0] as NSString).lastPathComponent
        
        let usage =
        """
        usage: \(executableName) <command> [<options>] [<args>]
        """
        
        CommandLine.print(usage)
    }
}
