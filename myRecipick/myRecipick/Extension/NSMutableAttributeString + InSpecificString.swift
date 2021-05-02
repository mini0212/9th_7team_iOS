//
//  NSMutableAttributeString + InSpecificString.swift
//  myRecipick
//
//  Created by hanwe on 2021/05/02.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit

extension NSMutableAttributedString {
    
    func addAttributedStringInSpecificString(targetString: String, attr: [NSAttributedString.Key: Any]) {
        let range = (self.string as NSString).range(of: targetString)
        self.addAttributes(attr, range: range)
    }
    
}
