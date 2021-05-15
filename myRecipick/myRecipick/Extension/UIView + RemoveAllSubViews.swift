//
//  UIView + RemoveAllSubViews.swift
//  myRecipick
//
//  Created by hanwe on 2021/05/01.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit

extension UIView {
    func removeAllSubview() {
        self.subviews.forEach({ $0.removeFromSuperview() })
    }
    
    func centerInSuperview(size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        }
        
        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}
