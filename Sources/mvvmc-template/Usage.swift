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
        
        # Generate files from template
        $ \(executableName) generate {Name}
        
        ## Options:
        --copyright or -C: Write copyright in header
        --project_name or -P: Write project name in header
        
        # Print implements for input/output protocol
        $ \(executableName) sync-impl {File name}
        
        """
        
        CommandLine.print(usage)
    }
}
