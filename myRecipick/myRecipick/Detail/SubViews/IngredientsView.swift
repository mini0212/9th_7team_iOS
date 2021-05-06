//
//  IngredientsView.swift
//  myRecipick
//
//  Created by hanwe lee on 2021/05/06.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit

class IngredientsView: UIView, NibIdentifiable {
    
    // MARK: outlet
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    
    // MARK: property
    
    // MARK: lifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }
    
    // MARK: func
    
    class func instance() -> IngredientsView? {
        return IngredientsView.nib.instantiate(withOwner: nil, options: nil).first as? IngredientsView
    }
    
    func initUI() {
        self.mainContainerView.backgroundColor = .clear
    }
    
    // MARK: action

}
