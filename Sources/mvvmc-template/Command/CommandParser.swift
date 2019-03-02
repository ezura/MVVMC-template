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
        
        guard let command = itr.next() else {
            return Result.failure(.commandMissing)
        }
        let options = consumeOptions()
        let args = consumeArgs()
        
        return .success((command: command, options: options, args: args))
    }
    
    private func consumeOptions() -> Options {
        var optionsBuffer: Options = [:]
        var tmpItr = itr

        while true {
            guard let optionKind = tmpItr.next(), optionKind.hasPrefix("-") else {
                return optionsBuffer
            }
            optionsBuffer[optionKind] = nil
            itr = tmpItr // consume

            guard let optionValue = tmpItr.next(), !optionValue.hasPrefix("-") else {
                continue
            }
            optionsBuffer[optionKind] = optionValue
            itr = tmpItr // consume
        }
    }
    
    private func consumeArgs() -> [String] {
        return itr.map { $0 } // The rest all are args
    }
}
