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
}
