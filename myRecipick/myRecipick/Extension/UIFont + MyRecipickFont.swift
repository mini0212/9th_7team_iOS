//
//  UIFont + MyRecipickFont.swift
//  myRecipick
//
//  Created by hanwe on 2021/04/29.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit

enum MyRecipickFonts {
    case title1
    case title2
    case title3
    case title4
    case subTitle1
    case subTitle2
    case body1
    case body2
    case caption
    case button
    case yourRecipe
    case cardCustomMenuTitle
    case detailMenuTitle
}

extension UIFont {
    static func myRecipickFont(_ font: MyRecipickFonts) -> UIFont {
        var tmpFont: UIFont?
        switch font {
        case .title1:
            tmpFont = UIFont(name: FontKeys.bold, size: 28)
        case .title2:
            tmpFont = UIFont(name: FontKeys.regular, size: 24)
        case .title3:
            tmpFont = UIFont(name: FontKeys.medium, size: 20)
        case .title4:
            tmpFont = UIFont(name: FontKeys.medium, size: 18)
        case .subTitle1:
            tmpFont = UIFont(name: FontKeys.bold, size: 16)
        case .subTitle2:
            tmpFont = UIFont(name: FontKeys.medium, size: 14)
        case .body1:
            tmpFont = UIFont(name: FontKeys.regular, size: 16)
        case .body2:
            tmpFont = UIFont(name: FontKeys.regular, size: 14)
        case .caption:
            tmpFont = UIFont(name: FontKeys.medium, size: 12)
        case .button:
            tmpFont = UIFont(name: FontKeys.medium, size: 14)
        case .yourRecipe:
            tmpFont = UIFont(name: FontKeys.regular, size: 12)
        case .cardCustomMenuTitle:
            tmpFont = UIFont(name: FontKeys.bold, size: 20)
        case .detailMenuTitle:
            tmpFont = UIFont(name: FontKeys.bold, size: 24)
        }
        guard let returnFont = tmpFont else { print("font is null") ; return UIFont() }
        return returnFont
    }
}
