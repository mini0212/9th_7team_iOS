//
//  SplashView.swift
//  myRecipick
//
//  Created by hanwe on 2021/04/19.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit

class SplashView: UIView, NibIdentifiable {

    // MARK: IBOutlet
    
    // MARK: property
    
    // MARK: lifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }
    
    // MARK: private function
    
    private func initUI() {
        
    }
    
    // MARK: internal function
    
    class func instance() -> SplashView? {
        return nib.instantiate(withOwner: nil, options: nil).first as? SplashView
    }
    
    
    // MARK: action
    
}
