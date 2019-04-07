//
//  Template.swift
//  mvvmc-template
//
//  Created by yuka ezura on 2019/02/24.
//

import Foundation
import Files
import ShellOut

enum Template {
    static func outputToFile(setting: Setting) throws { 
        let rootFolder = FileSystem().currentFolder
        let workFolderName = setting.fileBaseName + "Set"
        let mainFolderName = setting.fileBaseName
        
        print("Creating ./\(workFolderName)")
        let workFolder = try rootFolder.createSubfolderIfNeeded(withName: workFolderName)
        defer {
            do { try shellOut(to: "open \(workFolder.path)") } catch { print(error) }
        }
        
        if workFolder.containsSubfolder(named: mainFolderName) {
            print("Deleting old files: \(workFolderName)/\(mainFolderName)")
            try workFolder.subfolder(named: mainFolderName).delete()
        }
        
        print("Creating \(workFolderName)/\(mainFolderName)")
        let folder = try workFolder.createSubfolder(named: mainFolderName)
        
        try [("Model", Template.modelTemplate),
             ("ViewController", Template.viewControllerTemplate),
             ("ViewModel", Template.viewModelTemplate),
             ("Coordinator", Template.coordinatorTemplate)]
            .forEach {
                print("Creating \(folder.name)/\(setting.fileBaseName + $0)")
                try folder.createFile(named: "\(setting.fileBaseName)\($0).swift",
                    contents: setting.headerFor(typeName: $0) + "\n" + $1(setting.identifierName))
        }
        
        print("Creating \(workFolder.name)/\(setting.fileBaseName)CoordinatorTests")
        try workFolder.createFile(named: "\(setting.fileBaseName)CoordinatorTests.swift",
            contents: setting.headerFor(typeName: "CoordinatorTests") + "\n" + Template.coordinatorTestsTemplate(setting.identifierName))
    }
}
