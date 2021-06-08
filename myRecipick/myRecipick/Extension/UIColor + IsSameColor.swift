//
//  UIColor + IsSameColor.swift
//  myRecipick
//
//  Created by hanwe on 2021/06/08.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit

extension UIColor {
    func isSameColor(_ otherColor: UIColor) -> Bool {
        var r1: CGFloat = 0, g1: CGFloat = 0, b1: CGFloat = 0, a1: CGFloat = 0
        var r2: CGFloat = 0, g2: CGFloat = 0, b2: CGFloat = 0, a2: CGFloat = 0
        self.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        otherColor.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        return (r1 == r2) && (g1 == g2) && (b1 == b2) && (a1 == a2)
    }
}
