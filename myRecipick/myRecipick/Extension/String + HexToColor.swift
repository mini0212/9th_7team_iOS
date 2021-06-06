//
//  String + HexToColor.swift
//  myRecipick
//
//  Created by hanwe on 2021/06/06.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit

extension String {
    func hexToColor() -> UIColor {
        let cString: String = self.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if cString.count != 6 {
            return UIColor.gray
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
