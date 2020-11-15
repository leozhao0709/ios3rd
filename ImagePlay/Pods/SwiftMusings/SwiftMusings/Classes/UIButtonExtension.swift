//
//  UIButtonExtension.swift
//
//  Created by Lei Zhao on 9/2/16.
//  Copyright © 2016 Lei Zhao. All rights reserved.
//

import UIKit

@available(macCatalyst 13.0, *)
extension UIButton {
    
    public convenience init(normalImage: UIImage?, highlightImage: UIImage?, selectedImage: UIImage? = nil) {
        self.init(type: UIButton.ButtonType.custom)
        self.setImage(normalImage, highlightImage: highlightImage, selectedImage: selectedImage)
    }
    
    // MARK: - Button UI
    /**
     Set Image button. if you want to use image as a button, use this method
     
     - parameter normalImage:    normal state image
     - parameter highlightImage: highlight state image
     */
    func setImage(_ normalImage: UIImage?, highlightImage: UIImage?, selectedImage: UIImage? = nil){
        //Note: It's setImage, not setBackgroundImage
        self.setImage(normalImage, for: UIControl.State.normal)
        self.setImage(highlightImage, for: UIControl.State.highlighted)
        self.setImage(selectedImage, for: .selected)
    }
    
    func setBackgroundImage(_ normalImage: UIImage?, highlightImage: UIImage?, selectedImage: UIImage? = nil) {
        self.setBackgroundImage(normalImage, for: .normal)
        self.setBackgroundImage(highlightImage, for: .highlighted)
        self.setBackgroundImage(selectedImage, for: .selected)
    }
    
    func setTitleColor(_ normalColor: UIColor?, highlightColor: UIColor?, selectedColor: UIColor? = nil, disabledColor: UIColor? = nil) {
        self.setTitleColor(normalColor, for: .normal)
        self.setTitleColor(highlightColor, for: .highlighted)
        self.setTitleColor(selectedColor, for: .selected)
        self.setTitleColor(disabledColor, for: .disabled)
    }
    
}
