//
//  YourPageTableViewCell.swift
//  myRecipick
//
//  Created by hanwe on 2021/05/02.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit

protocol YourPageTableViewCellDelegate: AnyObject {
    func isClicked(_ cell: UITableViewCell, indexPath: IndexPath)
}

class YourPageTableViewCell: UITableViewCell {

    // MARK: IBOutlet
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var menuTitleLabel: UILabel!
    @IBOutlet weak var menuRecipeLabel: UILabel!
    @IBOutlet weak var editContainerView: UIView!
    @IBOutlet weak var editContainerViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var editBtnImgView: UIImageView!
    
    // MARK: property
    
    var originEditContainerViewWidthConstraint: CGFloat = 0
    var indexPath: IndexPath?
    weak var delegate: YourPageTableViewCellDelegate?
    
    // MARK: State
    var isChecked: Bool = false
    var isEditable: Bool = true
    
    // MARK: lifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }
    
    // MARK: function
    
    func initUI() {
        self.mainContainerView.backgroundColor = .clear
        self.menuTitleLabel.font = UIFont.myRecipickFont(.subTitle2)
        self.menuTitleLabel.textColor = UIColor(asset: Colors.grayScale33)
        self.menuRecipeLabel.font = UIFont.myRecipickFont(.yourRecipe)
        self.menuRecipeLabel.textColor = UIColor(asset: Colors.grayScale66)
        self.editContainerView.backgroundColor = .clear
        self.originEditContainerViewWidthConstraint = self.editContainerViewWidthConstraint.constant
    }
    
    func refreshStateUI() {
        if self.isChecked {
            self.editBtnImgView.image = Images.editCheck.image
            
        } else {
            self.editBtnImgView.image = Images.editNonCheck.image
        }
        
        if isEditable {
            self.editContainerView.isHidden = false
            self.editContainerViewWidthConstraint.constant = self.originEditContainerViewWidthConstraint
        } else {
            self.editContainerViewWidthConstraint.constant = 0
            self.editContainerView.isHidden = true
        }
    }
    
    // MARK: action
    @IBAction func editBtnClickedAction(_ sender: Any) {
        guard let path = self.indexPath else { print("indexPath is null") ; return  }
        self.delegate?.isClicked(self, indexPath: path)
    }
}
