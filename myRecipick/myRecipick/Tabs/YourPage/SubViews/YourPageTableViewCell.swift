//
//  YourPageTableViewCell.swift
//  myRecipick
//
//  Created by hanwe on 2021/05/02.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit
import Kingfisher

protocol YourPageTableViewCellDelegate: AnyObject {
    func isClicked(_ cell: UITableViewCell, indexPathRow: Int)
    func cellClicked(indexPathRow: Int, data: CustomMenuObjModel)
}

class YourPageTableViewCell: UITableViewCell, ClassIdentifiable, NibIdentifiable {

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
    var row: Int?
    weak var delegate: YourPageTableViewCellDelegate?
    
    var infoData: CustomMenuObjModel? {
        didSet {
            guard let info = self.infoData else { return }
            self.menuTitleLabel.text = info.name
            self.menuRecipeLabel.text = info.description
            if let imgUrl = info.imageUrl {
                self.imgView.kf.setImage(with: URL(string: imgUrl), placeholder: Images.sample.image, options: [.cacheMemoryOnly], completionHandler: { [weak self] _ in
                    self?.imgView.fadeIn(duration: 0.1, completeHandler: nil)
                })
            }
        }
    }
    
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
        guard let row = self.row else { print("indexPath is null") ; return  }
        self.delegate?.isClicked(self, indexPathRow: row)
    }
    @IBAction func cellClickedAction(_ sender: Any) {
        guard let row = self.row else { return }
        guard let info = self.infoData else { return }
        self.delegate?.cellClicked(indexPathRow: row, data: info)
    }
}
