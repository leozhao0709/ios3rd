//
//  UIImageViewExtension.swift
//
//  Created by Lei Zhao on 9/2/16.
//  Copyright © 2016 Lei Zhao. All rights reserved.
//

import UIKit

@available(macCatalyst 13.0, *)
extension UIImageView {
    
    /**
     Fade a new Image in ImageView
     */
    public func fadeImageIn(_ image: UIImage?, closure: ((_ image: UIImage?) -> ())? = nil) {
        if let image = image {
            self.image = image
            
            //fade in
            let transition = CATransition()
            transition.duration = 0.5
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = .fade
            self.layer.add(transition, forKey: nil)
            
            closure?(image)
            
        } else {
            return
        }
    }
    
}
