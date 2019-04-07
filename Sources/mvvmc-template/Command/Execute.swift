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
        let templateSetting = Template.Setting.custom(baseName: name,
                                                      copyright: options.first { $0.0 == "--copyright" || $0.0 == "-C" }?.1 ?? "",
                                                      projectName: options.first { $0.0 == "--project_name" || $0.0 == "-P" }?.1 ?? "")
        try Template.outputToFile(setting: templateSetting)
    case .printImplement(let filePath):
        let url = URL(fileURLWithPath: filePath)
        ImplementWriter().printImplementation(fileURL: url)
    }
}
