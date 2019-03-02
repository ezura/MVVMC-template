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
    case .generate(let name, let options):
        let rootFolder = FileSystem().currentFolder
        let workFolderName = name + "Set"
        let mainFolderName = name
        let copyright = options.first { $0.0 == "--copyright" || $0.0 == "-C" }?.1 ?? ""

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

        try [("Model", Template.modelTemplate),
             ("ViewController", Template.viewControllerTemplate),
             ("ViewModel", Template.viewModelTemplate),
             ("Coordinator", Template.coordinatorTemplate)]
            .forEach {
                // TODO: projectName and copyright
                let headar = Template.headerTemplate(fileName: "\(name)\($0).swift",
                                                     projectName: "",
                                                     userName: username,
                                                     date: date,
                                                     copyright: copyright)
                print("Creating \(folder.name)/\(name + $0)")
                try folder.createFile(named: "\(name)\($0).swift",
                                      contents: headar + $1(name))
        }

        print("Creating \(workFolder.name)/\(name)CoordinatorTests")
        // TODO: projectName and copyright
        let testFileHeadar = Template.headerTemplate(fileName:"\(name)CoordinatorTests.swift",
            projectName: "",
            userName: username,
            date: date,
            copyright: "")
        try workFolder.createFile(named: "\(name)CoordinatorTests.swift",
            contents: testFileHeadar + Template.coordinatorTestsTemplate(name))
    }
}
