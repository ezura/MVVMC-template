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
        try generateFiles(groupName: name,
                          objectName: name,
                          fileBaseName: name,
                          rootFolder: FileSystem().currentFolder,
                          shouldHaveHeader: false)
    case .install(let name):
        let objectName = "___FILEBASENAMEASIDENTIFIER___"
        let fileBaseName = "___FILEBASENAME___"
        let homeFolder = FileSystem().homeFolder
        let templateFolder = try homeFolder.subfolder(atPath: "Library/Developer/Xcode/Templates/File Templates")
        try generateFiles(groupName: name,
                          objectName: objectName,
                          fileBaseName: fileBaseName,
                          rootFolder: templateFolder,
                          shouldHaveHeader: true)
    }
}

/// # Output
///
/// rootFolder
///   |- {groupName}
///      |- {fileBaseName}ViewModel
///      |- {fileBaseName}Model
///      |- ...
///
/// # In file
///
/// ```
/// class {objectName}ViewModel {
///     ...
/// }
/// ```
private func generateFiles(groupName:String, objectName: String, fileBaseName: String, rootFolder: Folder, shouldHaveHeader: Bool) throws {
    let mainFolderName = groupName
    if rootFolder.containsSubfolder(named: mainFolderName) {
        print("Deleting old files: \(rootFolder.name)/\(mainFolderName)")
        try rootFolder.subfolder(named: mainFolderName).delete()
    }

    print("Creating \(rootFolder.name)/\(mainFolderName)")
    let folder = try rootFolder.createSubfolder(named: mainFolderName)

    try [("Model", Template.modelTemplate),
         ("ViewController", Template.viewControllerTemplate),
         ("ViewModel", Template.viewModelTemplate),
         ("Coordinator", Template.coordinatorTemplate),
         ("CoordinatorTests", Template.coordinatorTestsTemplate)]
        .forEach {
            print("Creating \(folder.name)/\(fileBaseName + $0)")
            try folder.createFile(named: "\(fileBaseName)\($0).swift",
                contents: (shouldHaveHeader ? Template.headerTemplate : "") +  $1(objectName))
    }
}
