//
//  YourPageZeroYourrecipeView.swift
//  myRecipick
//
//  Created by hanwe on 2021/05/02.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit

class YourPageZeroYourrecipeView: UIView, ClassIdentifiable {
    
    // MARK: IBOutlet
    @IBOutlet weak var backgroundContainerView: UIView!
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var contentsContainerView: UIView!
    @IBOutlet weak var contentsLabel: UILabel!
    
    // MARK: property
    
    // MARK: lifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }
    
    // MARK: function
    
    class func instance() -> YourPageZeroYourrecipeView? {
        return UINib(nibName: YourPageZeroYourrecipeView.identifier, bundle: .main).instantiate(withOwner: nil, options: nil).first as? YourPageZeroYourrecipeView
    }
    
    func initUI() {
        self.backgroundContainerView.backgroundColor = UIColor(asset: Colors.white)
        self.mainContainerView.backgroundColor = .clear
        self.contentsContainerView.backgroundColor = .clear
        self.contentsLabel.font = UIFont.myRecipickFont(.subTitle1)
        self.contentsLabel.textColor = UIColor(asset: Colors.grayScale99)
        self.contentsLabel.text = "등록된 커스텀 기록이 없어요."
    }
    
    // MARK: action

}
