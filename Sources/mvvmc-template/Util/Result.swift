//
//  Result.swift
//  mvvmc-template
//
//  Created by yuka ezura on 2019/02/23.
//

import Foundation

enum Result<Value, Error> {
    case success(Value)
    case failure(Error)
}
