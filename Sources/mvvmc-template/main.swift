do {
    let syntaxParsedResult = CommandParser(args: CommandLine.arguments).parse()
    switch syntaxParsedResult {
    case .success(let syntaxParsed):
        let semaParsed = CommandInterpreter().interpret(input: syntaxParsed)
        switch semaParsed {
        case .success(let command):
            try execute(command: command)
        case .failure(let error):
            print(error)
        }
    case .failure(let error):
        print(error)
    }
} catch {
    print(error)
}
