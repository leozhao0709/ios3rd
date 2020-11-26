//
//  Utils.swift
//
//  Created by Lei Zhao on 9/4/16.
//  Copyright © 2016 Lei Zhao. All rights reserved.
//

import Foundation

/**
 just want code autoCompletion
 
 - parameter format: Log String
 */
public func printLog(_ item: Any, fileName: String = #file, lineNumber: Int = #line, columnNumber: Int = #column) {
    #if DEBUG
        
        NSLog("\((fileName as NSString).lastPathComponent)[\(lineNumber):\(columnNumber)]: \(item)")
    #endif
}

public func printActionLog(function: String = #function, fileName: String = #file, lineNumber: Int = #line, columnNumber: Int = #column) {
    #if DEBUG
        NSLog("\((fileName as NSString).lastPathComponent)[\(lineNumber):\(columnNumber)]: \(function)")
    #endif
}
