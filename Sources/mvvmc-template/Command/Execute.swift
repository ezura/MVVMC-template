//
//  Execute.swift
//  mvvmc-template
//
//  Created by yuka ezura on 2019/02/24.
//

import Foundation
import Files
import ShellOut

func execute(command: Command) throws {
    switch command {
    case .empty(options: let options):
        if options.contains(where: { $0.0.contains("help") }) {
            Usage.print()
        } else {
            print("command not found. If you read usage, please use `--help`")
        }
    case .generate(let name, let options):
        let templateSetting: Template.Setting
        if options.contains(where: { $0.0 ==  "--xcode_template" }) {
            templateSetting = .xcodeTemplate
        } else {
            guard let name = name else {
                return print("need name")
            }
            templateSetting = Template.Setting.custom(baseName: name,
                                                      copyright: options.first { $0.0 == "--copyright" || $0.0 == "-C" }?.1 ?? "",
                                                      projectName: options.first { $0.0 == "--project_name" || $0.0 == "-P" }?.1 ?? "")
        }
        try Template(config: templateSetting).writeToFiles()
    case .sortImpl(let path):
        FileVisitor().visit(directoryOrFilePath: path, fileExtension: "swift") { (fileURL) in
            ImplementWriter().sort(fileURL: fileURL)
        }
    }
}
