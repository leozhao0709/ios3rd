//
//  File.swift
//
//  Created by Lei Zhao on 10/12/16.
//  Copyright © 2016 Lei Zhao. All rights reserved.
//

import Foundation

extension FileManager {
    
    public static func getDocumentDir()->String {
        NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
    }
    
    public static func getCacheDir()->String {
        NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
    }
    
    public static func getTempDir()->String {
        NSTemporaryDirectory()
    }
    
    
}
