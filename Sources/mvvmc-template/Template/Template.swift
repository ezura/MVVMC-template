//
//  Template.swift
//  mvvmc-template
//
//  Created by yuka ezura on 2019/02/24.
//

import Foundation
import Files
import ShellOut

struct Template {
    let config: Template.Setting
    
    func writeToFiles() throws {
        switch config {
        case .custom(let baseName, let copyright, let projectName):
            try Template.writeToFilesAsCustomTemplate(baseName: baseName,
                                                      copyright: copyright, 
                                                      projectName: projectName)
        case .xcodeTemplate:
            try Template.writeToFilesAsXcodeTemplate()
        }
    }
    
    private static func writeToFilesAsCustomTemplate(baseName: String, copyright: String?, projectName: String?) throws {
        let rootFolder = FileSystem().currentFolder
        let workFolderName = baseName + "Set"
        let mainFolderName = baseName
        
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
        
        // header
        let username = try? shellOut(to: "git config user.name")
        let date = try? shellOut(to: "date \"+%Y/%m/%d\"")
        func headerFor(typeName: String) -> String { 
            return Template.headerTemplate(fileName: "\(baseName)\(typeName).swift",
                projectName: projectName ?? "",
                userName: username ?? "",
                date: date ?? "",
                copyright: copyright ?? "")
        }
        
        // generate files
        try [("Model", Template.modelTemplate),
             ("ViewController", Template.viewControllerTemplate),
             ("ViewModel", Template.viewModelTemplate(parentLayerName: "Coordinator")),
             ("Coordinator", Template.coordinatorTemplate)]
            .forEach {
                print("Creating \(folder.name)/\(baseName + $0)")
                try folder.createFile(named: "\(baseName)\($0).swift",
                    contents: headerFor(typeName: $0) + "\n" + $1(baseName))
        }
        
        print("Creating \(workFolder.name)/\(baseName)CoordinatorTests")
        try workFolder.createFile(named: "\(baseName)CoordinatorTests.swift",
            contents: headerFor(typeName: "CoordinatorTests") + "\n" +
                Template.coordinatorTestsTemplate(baseName))
    }
    
    private static func writeToFilesAsXcodeTemplate() throws {
        let rootFolder = FileSystem().currentFolder
        let baseName = "___VARIABLE_productName___"
        let workFolderName = "MVVMC.xctemplate"
        
        print("Creating ./\(workFolderName)")
        let workFolder = try rootFolder.createSubfolderIfNeeded(withName: workFolderName)
        defer {
            do { try shellOut(to: "open \(workFolder.path)") } catch { print(error) }
        }
        
        // generate each role template
        try Template.Role.allCases
            .forEach { (role: Template.Role) in
                let folderName = role.roleName + role.suffixForOption
                let fileName = role.xcodeTemplatefileNameWith(baseName: baseName)
                let contentTemplate = role.templateContent
                
                if workFolder.containsSubfolder(named: folderName) {
                    print("Deleting old files: \(workFolderName)/\(folderName)")
                    try workFolder.subfolder(named: folderName).delete()
                }
                print("Creating \(workFolderName)/\(folderName)")
                let folder = try workFolder.createSubfolder(named: folderName)
                
                print("Creating \(folder.name)/\(fileName)")
                try folder.createFile(named: fileName,
                    contents: Template.headerTemplateAsXcodeTemplate + "\n" + contentTemplate(baseName))
        }
        
        /// generate template containing all templates without file of test target
        func generateForAllTemplate(isConnectingWithCoordinator: Bool) throws {
            let allTemplatesContainingName = isConnectingWithCoordinator ? "AllCoordinatorOutputs" : "All"
            if workFolder.containsSubfolder(named: allTemplatesContainingName) {
                print("Deleting old files: \(workFolderName)/\(allTemplatesContainingName)")
                try workFolder.subfolder(named: allTemplatesContainingName).delete()
            }
            print("Creating \(workFolderName)/\(allTemplatesContainingName)")
            let allTemplatesContainingFolder = try workFolder.createSubfolder(named: allTemplatesContainingName)
            try [Template.Role.model,
                 .viewModel(isConnectingWithCoordinator: isConnectingWithCoordinator),
                 .viewController,
                 .coordinator]
                .forEach { (role: Template.Role) in
                    let fileName = role.xcodeTemplatefileNameWith(baseName: baseName)
                    let contentTemplate = role.templateContent          
                    print("Creating \(allTemplatesContainingFolder.name)/\(fileName)")
                    try allTemplatesContainingFolder.createFile(named: fileName,
                        contents: Template.headerTemplateAsXcodeTemplate + "\n" + contentTemplate(baseName))
            }
        }
        
        // for template of "All"
        try generateForAllTemplate(isConnectingWithCoordinator: false)
        
        // for template of "CoordinatorOutputsAll"
        try generateForAllTemplate(isConnectingWithCoordinator: true)
    }
}
