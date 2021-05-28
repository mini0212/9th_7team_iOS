//
//  String + Localized.swift
//  myRecipick
//
//  Created by hanwe on 2021/04/29.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit

extension String {
    var localized: String {
        UserDefaults.standard.set(NSLocale.current.languageCode, forKey: "i18n_language")
        let lang = UserDefaults.standard.string(forKey: "i18n_language")
        
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        let bundle = Bundle(path: path!)
        
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
    

}
