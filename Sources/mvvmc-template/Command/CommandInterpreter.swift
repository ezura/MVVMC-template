//
//  CommandInterpreter.swift
//  mvvmc-template
//
//  Created by yuka ezura on 2019/02/24.
//

import Foundation

extension CommandInterpreter {    
    enum InterpretError {
        case commandMissing
        case argumentMissing(message: String)
    }
}

final class CommandInterpreter {
    func interpret(input: ParsedCommand) -> Result<Command, InterpretError> {
        switch input.command {
        case "":
            return .success(.empty(options: input.options))
        case "generate":
            let name = input.args.first
            return .success(.generate(name: name, options: input.options))
        case "sync-implement", "sync-impl":
            guard let filePath = input.args.first else {
                return .failure(.argumentMissing(message: "need file URL"))
            }
            return .success(.printImplement(filePath: filePath))
        default:
            return .failure(.commandMissing)
        }
    }
}
