dump(CommandLine.arguments)
let tokens = CommandParser(args: CommandLine.arguments).parse()
print(tokens)
