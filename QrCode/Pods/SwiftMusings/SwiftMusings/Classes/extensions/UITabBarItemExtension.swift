//
//  UITabBarItemExtension.swift
//
//  Created by Lei Zhao on 9/4/16.
//  Copyright © 2016 Lei Zhao. All rights reserved.
//

import UIKit

@available(macCatalyst 13.0, *)
extension UITabBarItem {
    
    public func setImageWithOriginalImage(_ normalImage: UIImage?, selectedImage: UIImage?) {
        if let normalImage = normalImage {
            self.image = normalImage.withRenderingMode(.alwaysOriginal)
        }
        
        if let selectedImage = selectedImage {
            self.selectedImage = selectedImage.withRenderingMode(.alwaysOriginal)
        }
    }
    
    public func setTitleTextColor(_ normalColor: UIColor?, selectedColor: UIColor?) {
        if let normalColor = normalColor {
            let normalTitleAttribute: [NSAttributedString.Key: AnyObject]? = [.foregroundColor: normalColor]
            self.setTitleTextAttributes(normalTitleAttribute, for: UIControl.State.normal)
        }
        if let selectedColor = selectedColor {
            let selectedTitleAttribute: [NSAttributedString.Key: AnyObject]? = [.foregroundColor: selectedColor]
            self.setTitleTextAttributes(selectedTitleAttribute, for: UIControl.State.selected)
        }
        
        
    }
    
}
