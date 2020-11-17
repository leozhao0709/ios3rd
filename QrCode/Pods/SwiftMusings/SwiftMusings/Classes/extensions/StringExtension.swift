//
//  StringExtension.swift
//
//  Created by Lei Zhao on 9/18/16.
//  Copyright © 2016 Lei Zhao. All rights reserved.
//

import UIKit

extension String {
    
    /// file system
    ///
    /// - returns: file path
    public func appendFilePath(path: String)->String?{
        (self as NSString).appendingPathComponent(path)
    }
    
}
