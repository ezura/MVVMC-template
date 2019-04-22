//
//  FileVisitor.swift
//  textoru
//
//  Created by yuka ezura on 2019/03/15.
//

import Foundation
import Files

class FileVisitor {
    typealias OnFoundBlock = (URL) -> Void
    
    func visit(directoryOrFilePath rootPath: String, fileExtensions: String..., onFound: OnFoundBlock) {
        for fileExtension in fileExtensions {
            visit(directoryOrFilePath: rootPath, fileExtension: fileExtension, onFound: onFound)
        }
    }
    
    func visit(directoryOrFilePath rootPath: String, fileExtension: String, onFound: OnFoundBlock) {
        let currentFolder = FileSystem().currentFolder
        
        if let folder = try? currentFolder.subfolder(atPath: rootPath) {
            for file in folder.makeFileSequence(recursive: true, includeHidden: false) where file.extension == fileExtension {
                onFound(URL(fileURLWithPath: file.path))
            }
        } else if let file = try? currentFolder.file(atPath: rootPath) {
            onFound(URL(fileURLWithPath: file.path))
        } else {
            print("error: \(rootPath) is not found.")
        }
    }
}
