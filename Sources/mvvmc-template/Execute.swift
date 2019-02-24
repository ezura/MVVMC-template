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
    case .generate(let name):
        let rootFolderName = name + "Set"
        print("Creating ./\(rootFolderName)")
        let rootFolder = try FileSystem().createFolderIfNeeded(at: rootFolderName)

        let mainFolderName = name
        if rootFolder.containsSubfolder(named: mainFolderName) {
            print("Deleting old files: \(rootFolderName)/\(mainFolderName)")
            try rootFolder.subfolder(named: mainFolderName).delete()
        }

        print("Creating \(rootFolderName)/\(name)")
        let folder = try rootFolder.createSubfolder(named: mainFolderName)

        try [("Model", Template.modelTemplate),
             ("ViewController", Template.viewControllerTemplate),
             ("ViewModel", Template.viewModelTemplate),
             ("Coordinator", Template.coordinatorTemplate),
             ("CoordinatorTests", Template.coordinatorTestsTemplate)]
            .forEach {
                print("Creating \(folder.name)/\(name + $0)")
                try folder.createFile(named: "\(name)\($0).swift",
                                      contents: $1(name))
        }

        print("Creating \(rootFolder.name)/\(name)CoordinatorTests")
        try rootFolder.createFile(named: "\(name)CoordinatorTests.swift",
            contents: Template.coordinatorTestsTemplate(name))
    }
}
