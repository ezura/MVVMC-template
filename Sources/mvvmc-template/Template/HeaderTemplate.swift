//
//  HeaderTemplate.swift
//  Files
//
//  Created by EZURA YUKA on 2019/02/26.
//

import Foundation

extension Template {
    static let headerTemplate: String =
        """
        //
        //  ___FILENAME___
        //  ___PROJECTNAME___
        //
        //  Created by ___FULLUSERNAME___ on ___DATE___.
        //  ___COPYRIGHT___
        //
        """
    
    static let headerTemplateAsXcodeTemplate: String = 
        """
        //___FILEHEADER___
        """
            .appending("\n")

    static func headerTemplate(fileName: String, projectName: String, userName: String, date: String, copyright: String) -> String {
        let prefix = "//  "
        let header =
        """
        
        \(fileName)
        \(projectName)
        
        Created by \(userName) on \(date).
        \(copyright)
        
        """
            .split(separator: "\n", 
                   maxSplits: Int.max,
                   omittingEmptySubsequences: false)
            .map { prefix + $0 }
            .joined(separator: "\n")
            .appending("\n")
        return header
    }
}
