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
        usage: \(executableName) [<options>] <command> [<args>]
        
        generate [--no-model | -nm] <name>:
            generate `<name>ViewModel`, `<name>ViewCoordinator`, `<name>Model`.
        
            If you want files for a profile screen, run `\(executableName) generate Profile`.
            Then, generate `ProfileViewModel`, `ProfileModel`, `ProfileViewCoordinator`.
        
            If model is unnecessary,
            run `\(executableName) generate --no-model Profile` or
            run `\(executableName) generate -nm Profile`
        """
        
        CommandLine.print(usage)
    }
}
