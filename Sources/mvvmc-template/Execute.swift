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
        let rootFolder = try FileSystem().createFolder(at: rootFolderName)

        print("Creating ./\(rootFolderName)/\(name)")
        let folder = try rootFolder.createSubfolder(named: name)

        try [("Model", Template.modelTemplate),
             ("ViewController", Template.viewControllerTemplate),
             ("ViewModel", Template.viewModelTemplate),
             ("Coordinator", Template.coordinatorTemplate),
             ("CoordinatorTests", Template.coordinatorTestsTemplate)]
            .forEach {
                print("Creating \(folder.path)/\(name + $0)")
                try folder.createFile(named: "\(name)\($0).swift",
                                      contents: $1(name))
        }
    }
}
