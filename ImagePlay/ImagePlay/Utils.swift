//
// Created by Lei Zhao on 11/14/20.
//

import Foundation

/**
 just want code autoCompletion

 - parameter format: Log String
 */
func printLog(message: String, fileName: String = #file, lineNumber: Int = #line, columnNumber: Int = #column) {
    #if DEBUG

        NSLog("\((fileName as NSString).lastPathComponent)[\(lineNumber):\(columnNumber)]: \(message)")
    #endif
}

func printActionLog(function: String = #function, fileName: String = #file, lineNumber: Int = #line, columnNumber: Int = #column) {
    #if DEBUG
        NSLog("\((fileName as NSString).lastPathComponent)[\(lineNumber):\(columnNumber)]: \(function)")
    #endif
}