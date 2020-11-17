//
//  UIViewExtension.swift
//
//  Created by Lei Zhao on 9/12/16.
//  Copyright © 2016 Lei Zhao. All rights reserved.
//

import UIKit

@available(macCatalyst 13.0, *)
extension UIView {

    var x: CGFloat {
        get {
            self.frame.origin.x
        }

        set(newValue) {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }

    var y: CGFloat {
        get {
            self.frame.origin.y
        }

        set(newValue) {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }

    }

    var width: CGFloat {
        get {
            self.frame.width
        }
        set(newValue) {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }

    var height: CGFloat {
        get {
            self.frame.height
        }
        set(newValue) {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }

    var centerX: CGFloat {
        get {
            self.center.x
        }

        set(newValue) {
            var tempCenter = self.center
            tempCenter.x = newValue
            self.center = tempCenter
        }

    }

    var centerY: CGFloat {
        get {
            self.center.y
        }

        set(newValue) {
            var tempCenter = self.center
            tempCenter.y = newValue
            self.center = tempCenter
        }
    }

    public func clipViewToImage() -> UIImage? {
        UIGraphicsBeginImageContext(self.frame.size)

        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        self.layer.render(in: context)

        let image = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return image
    }
}
