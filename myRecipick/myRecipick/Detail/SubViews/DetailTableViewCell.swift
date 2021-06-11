//
//  DetailTableViewCell.swift
//  myRecipick
//
//  Created by hanwe on 2021/05/16.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell, ClassIdentifiable {
    
    enum CellType {
        case menu
        case ingredients
    }

    // MARK: IBOutlet
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentsLabel: UILabel!
    
    // MARK: property
    
    var type: CellType = .ingredients {
        didSet {
            switch self.type {
            case .menu:
                self.titleLabel.textColor = UIColor(asset: Colors.secondaryGreen)
            case .ingredients:
                self.titleLabel.textColor = UIColor(asset: Colors.grayScale99)
            }
        }
    }
    
    var detailMenuInfoData: CustomMenuDetailOptionGroupOptionsObjModel? {
        didSet {
            guard let info = self.detailMenuInfoData else { return }
            if let url = info.imageUrl {
                self.imgView.kf.setImage(with: URL(string: url), placeholder: nil, options: [.cacheMemoryOnly], completionHandler: { [weak self] _ in
                    self?.imgView.fadeIn(duration: 0.1, completeHandler: nil)
                })
            }
            self.titleLabel.text = info.category
            self.contentsLabel.text = info.name
            
        }
    }
    
    var menuInfoData: CustomMenuDetailOriginalMenuObjModel? {
        didSet {
            guard let info = self.menuInfoData else { return }
            if let url = info.imageUrl {
                self.imgView.kf.setImage(with: URL(string: url), placeholder: nil, options: [.cacheMemoryOnly], completionHandler: { [weak self] _ in
                    self?.imgView.fadeIn(duration: 0.1, completeHandler: nil)
                })
            }
            self.titleLabel.text = "메뉴"
            self.contentsLabel.text = info.name
            
        }
    }
    
    
    // MARK: lifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }
    
    // MARK: function
    
    func initUI() {
        self.mainContainerView.backgroundColor = UIColor(asset: Colors.white)
        self.titleLabel.font = UIFont.myRecipickFont(.caption)
        self.titleLabel.textColor = UIColor(asset: Colors.grayScale99)
        self.contentsLabel.font = UIFont.myRecipickFont(.subTitle2)
        self.contentsLabel.textColor = UIColor(asset: Colors.grayScale33)
    }
    
    // MARK: action
    
    

    
}
