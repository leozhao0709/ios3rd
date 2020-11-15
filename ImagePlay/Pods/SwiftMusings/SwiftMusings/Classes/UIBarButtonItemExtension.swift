//
//  UIBarButtonItemExtension.swift
//
//  Created by Lei Zhao on 9/15/16.
//  Copyright © 2016 Lei Zhao. All rights reserved.
//

import UIKit

@available(macCatalyst 13.0, *)
extension UIBarButtonItem {
    
    convenience init?(normalImage: UIImage?, highlightImage: UIImage?, target: AnyObject?, action: Selector) {
        let btn = UIButton(normalImage: normalImage, highlightImage: highlightImage)
        btn.sizeToFit()
//        btn.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        btn.addTarget(target, action: action, for: UIControl.Event.touchUpInside)
        self.init(customView: btn)
    }
    
    
}
