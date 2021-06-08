//
//  UIView + FadeInOut.swift
//  myRecipick
//
//  Created by hanwe lee on 2021/04/30.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit

extension UIView {
    func fadeOut(duration: TimeInterval = 0.2, completeHandler: (() -> Void)?) {
        self.alpha = 1.0
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { [weak self] in
            self?.alpha = 0.0
        }, completion: { (finished: Bool) -> Void in
            if finished {
                completeHandler?()
            }
        })
    }
    
    func fadeIn(duration: TimeInterval = 0.2, completeHandler: (() -> Void)?) {
        self.alpha = 0.0
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseIn, animations: { [weak self] in
            self?.alpha = 1.0
        }, completion: { (finished: Bool) -> Void in
            if finished {
                completeHandler?()
            }
        })
    }
}
