//
//  CommandParser.swift
//  mvvmc-template
//
//  Created by yuka ezura on 2019/02/23.
//

import Foundation

extension CommandParser {
    enum Command {
        case generate(name: String)
    }
    
    enum ParseError {
        case commandMissing
        case argumentMissing(message: String)
    }
}

class CommandParser {
    typealias ParseResult = Result<Command, ParseError>
    typealias Input = (command: String, options: [String], args: [String])
    
    private let wholeArgs: [String]
    private var itr: IndexingIterator<[String]>
    
    init(args: [String]) {
        self.wholeArgs = args
        self.itr = args.makeIterator()
    }
    
    func parse() -> ParseResult {
        _ = itr.next() // tool name
        
        guard let command = itr.next() else {
            return Result.failure(.commandMissing)
        }
        let options = consumeOptions()
        let args = consumeArgs()
        
        return interpret(input: (command: command, options: options, args: args))
    }
    
    private func consumeOptions() -> [String] {
        // todo: implement
        return []
    }
    
    private func consumeArgs() -> [String] {
        return itr.map { $0 } // The rest all are args
    }
    
    private func interpret(input: Input) -> ParseResult {
        switch input.command {
        case "generate":
            guard let name = input.args.first else {
                return .failure(.argumentMissing(message: "need name"))
            }
            return .success(.generate(name: name))
        default:
            return .failure(.commandMissing)
        }
    }
}
