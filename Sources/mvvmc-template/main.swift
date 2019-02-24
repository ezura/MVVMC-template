dump(CommandLine.arguments)
let syntaxParsedResult = CommandParser(args: CommandLine.arguments).parse()
dump(syntaxParsedResult)

switch syntaxParsedResult {
case .success(let syntaxParsed):
    let semantic = CommandInterpreter().interpret(input: syntaxParsed)
    dump(semantic)
case .failure(let error):
    print(error)
}

print(Template.coordinatorTemplate("Profile"))
