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
    typealias ParseResult = Result<ParsedCommand, ParseError>
    
    private let wholeArgs: [String]
    private var itr: IndexingIterator<[String]>
    
    init(args: [String]) {
        self.wholeArgs = args
        self.itr = args.makeIterator()
    }
    
    func parse() -> ParseResult {
        _ = itr.next() // tool name
        
        guard let command = consumeCommand() else {
            return Result.failure(.commandMissing)
        }
        let options = consumeOptions()
        let args = consumeArgs()
        
        return .success((command: command, options: options, args: args))
    }
    
    private func consumeCommand() -> String? {
        var tmpItr = itr
        guard let token = tmpItr.next() else {
            return nil
        }
        let command: String
        if token.hasPrefix("-") {
            // handle this token as option parameter, so doesn't consume this token and analyze it as empty command.
            command = ""
        } else {
            command = token
            itr = tmpItr
        }
        return command
    }
    
    private func consumeOptions() -> [Option] {
        var optionsBuffer: [Option] = []
        var tmpItr = itr

        while true {
            guard let token = tmpItr.next(), token.hasPrefix("-") else {
                return optionsBuffer
            }
            let optionKind = token
            itr = tmpItr

            if let token = tmpItr.next(), !token.hasPrefix("-") {
                optionsBuffer.append((optionKind, token))
                itr = tmpItr
            } else {
                optionsBuffer.append((optionKind, nil))
                continue
            }
        }
    }
    
    private func consumeArgs() -> [String] {
        return itr.map { $0 } // The rest all are args
    }
}
