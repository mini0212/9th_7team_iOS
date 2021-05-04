//
//  CustomMenuCardCollectionViewCell.swift
//  myRecipick
//
//  Created by hanwe lee on 2021/05/04.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit

class CustomMenuCardCollectionViewCell: UICollectionViewCell {
    
    // MARK: outlet
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var createdDateLabel: UILabel!
    @IBOutlet weak var mainImgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var menuNameContainerView: UIView!
    @IBOutlet weak var menuImgView: UIImageView!
    @IBOutlet weak var manuNameLabel: UILabel!
    
    // MARK: property
    
    // MARK: lifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }
    
    // MARK: func
    
    func initUI() {
        self.mainContainerView.layer.cornerRadius = 24
        self.createdDateLabel.font = UIFont.myRecipickFont(.yourRecipe)
        self.createdDateLabel.textColor = UIColor(asset: Colors.white)
        self.nameLabel.font = UIFont.myRecipickFont(.cardCustomMenuTitle)
        self.nameLabel.textColor = UIColor(asset: Colors.white)
        self.menuNameContainerView.backgroundColor = UIColor(asset: Colors.white)
        self.menuNameContainerView.layer.cornerRadius = 20
        self.manuNameLabel.font = UIFont.myRecipickFont(.yourRecipe)
        self.manuNameLabel.textColor = UIColor(asset: Colors.grayScale33)
    }
    
    // MARK: action

}
