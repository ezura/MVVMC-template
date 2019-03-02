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
        let rootFolderName = name + "Set"

        #warning("remove after debug")
        return
        print("Creating ./\(rootFolderName)")
        let rootFolder = try FileSystem().createFolderIfNeeded(at: rootFolderName)

        let mainFolderName = name
        if rootFolder.containsSubfolder(named: mainFolderName) {
            print("Deleting old files: \(rootFolderName)/\(mainFolderName)")
            try rootFolder.subfolder(named: mainFolderName).delete()
        }

        print("Creating \(rootFolderName)/\(name)")
        let folder = try rootFolder.createSubfolder(named: mainFolderName)

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
                                                     copyright: "")
                print("Creating \(folder.name)/\(name + $0)")
                try folder.createFile(named: "\(name)\($0).swift",
                                      contents: headar + $1(name))
        }

        print("Creating \(rootFolder.name)/\(name)CoordinatorTests")
        // TODO: projectName and copyright
        let testFileHeadar = Template.headerTemplate(fileName:"\(name)CoordinatorTests.swift",
            projectName: "",
            userName: username,
            date: date,
            copyright: "")
        try rootFolder.createFile(named: "\(name)CoordinatorTests.swift",
            contents: testFileHeadar + Template.coordinatorTestsTemplate(name))
    }
}
