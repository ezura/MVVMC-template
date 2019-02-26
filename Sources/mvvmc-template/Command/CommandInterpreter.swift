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
    func interpret(input: CommandParser.ParsedCommand) -> Result<Command, InterpretError> {
        switch input.command {
        case "generate":
            guard let name = input.args.first else {
                return .failure(.argumentMissing(message: "need name"))
            }
            return .success(.generate(name: name))
        case "install":
            return .success(.install(name: input.args.first ?? "MVVMC_Rx_template"))
        default:
            return .failure(.commandMissing)
        }
    }
}
