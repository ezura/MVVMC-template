//
//  CommandParser.swift
//  mvvmc-template
//
//  Created by yuka ezura on 2019/02/23.
//

import Foundation

extension CommandParser {
    enum ParseError {
        case commandMissing
    }
}

final class CommandParser {
    typealias ParsedCommand = (command: String, options: [String], args: [String])
    typealias ParseResult = Result<ParsedCommand, ParseError>
    
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
        
        return .success((command: command, options: options, args: args))
    }
    
    private func consumeOptions() -> [String] {
        // todo: implement
        return []
    }
    
    private func consumeArgs() -> [String] {
        return itr.map { $0 } // The rest all are args
    }
}
