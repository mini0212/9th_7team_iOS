//
//  RecommendedMenuCollectionViewCell.swift
//  myRecipick
//
//  Created by hanwe on 2021/05/29.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit

class RecommendedMenuCollectionViewCell: UICollectionViewCell, ClassIdentifiable {

    // MARK: IBOutlet
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var mainImgView: UIImageView!
    @IBOutlet weak var customMenuTitleLabel: UILabel!
    @IBOutlet weak var menuContainerView: UIView!
    @IBOutlet weak var menuImgView: UIImageView!
    @IBOutlet weak var menuNameLabel: UILabel!
    
    
    // MARK: property
    
    
    // MARK: lifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }
    
    
    // MARK: function
    func initUI() {
        self.mainContainerView.layer.cornerRadius = 24
        self.dateLabel.font = .myRecipickFont(.yourRecipe)
        self.dateLabel.textColor = UIColor(asset: Colors.white)
        self.customMenuTitleLabel.font = .myRecipickFont(.cardCustomMenuTitle)
        self.customMenuTitleLabel.textColor = UIColor(asset: Colors.white)
        self.menuContainerView.layer.cornerRadius = 20
        self.menuContainerView.backgroundColor = UIColor(asset: Colors.white)
        self.menuNameLabel.font = .myRecipickFont(.yourRecipe)
        self.menuNameLabel.textColor = UIColor(asset: Colors.grayScale33)
    }
    
    
    // MARK: action

}
