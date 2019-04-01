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
        let rootFolder = FileSystem().currentFolder
        let workFolderName = name + "Set"
        let mainFolderName = name
        let copyright = options.first { $0.0 == "--copyright" || $0.0 == "-C" }?.1 ?? ""
        let projectName = options.first { $0.0 == "--project_name" || $0.0 == "-P" }?.1 ?? ""

        print("Creating ./\(workFolderName)")
        let workFolder = try rootFolder.createSubfolderIfNeeded(withName: workFolderName)
        defer {
            do { try shellOut(to: "open \(workFolder.path)") } catch { print(error) }
        }

        if workFolder.containsSubfolder(named: mainFolderName) {
            print("Deleting old files: \(workFolderName)/\(mainFolderName)")
            try workFolder.subfolder(named: mainFolderName).delete()
        }

        print("Creating \(workFolderName)/\(name)")
        let folder = try workFolder.createSubfolder(named: mainFolderName)
        
        let username = try shellOut(to: "git config user.name")
        let date = try shellOut(to: "date \"+%Y/%m/%d\"")
        let header: (_ name: String, _ suffix: String) -> String = {
            return Template.headerTemplate(fileName: "\($0)\($1).swift",
                projectName: projectName,
                userName: username,
                date: date,
                copyright: copyright)
        }
        
        try [("Model", Template.modelTemplate),
             ("ViewController", Template.viewControllerTemplate),
             ("ViewModel", Template.viewModelTemplate),
             ("Coordinator", Template.coordinatorTemplate)]
            .forEach {
                print("Creating \(folder.name)/\(name + $0)")
                try folder.createFile(named: "\(name)\($0).swift",
                    contents: header(name, $0) + "\n" + $1(name))
        }

        print("Creating \(workFolder.name)/\(name)CoordinatorTests")
        try workFolder.createFile(named: "\(name)CoordinatorTests.swift",
            contents: header(name, "CoordinatorTests") + "\n" + Template.coordinatorTestsTemplate(name))
    case .printImplement(let filePath):
        let url = URL(fileURLWithPath: filePath)
        ImplementWriter().printImplementation(fileURL: url)
    }
}
