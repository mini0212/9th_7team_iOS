//
//  DetailCommentTableViewCell.swift
//  myRecipick
//
//  Created by hanwe on 2021/05/18.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit

class DetailCommentTableViewCell: UITableViewCell, ClassIdentifiable {

    // MARK: IBOutlet
    
    @IBOutlet weak var backgroundContainerView: UIView!
    @IBOutlet weak var mainContentsContainerView: UIView!
    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var contentsLabel: UILabel!
    
    // MARK: property
    
    // MARK: lifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }
    
    // MARK: function
    
    func initUI() {
        self.backgroundContainerView.backgroundColor = UIColor(asset: Colors.white)
        self.mainContentsContainerView.backgroundColor = UIColor(asset: Colors.white)
        self.bubbleView.backgroundColor = UIColor(asset: Colors.primaryLight2)
        self.bubbleView.layer.cornerRadius = 10
        self.contentsLabel.font = UIFont.myRecipickFont(.subTitle2)
        self.contentsLabel.textColor = UIColor(asset: Colors.primaryNormal)
    }
    
    // MARK: action
    
}
