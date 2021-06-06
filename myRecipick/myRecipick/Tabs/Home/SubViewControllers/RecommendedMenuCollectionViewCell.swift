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
    
    var infoData: RecommendCustomMenu? {
        didSet {
            guard let info = self.infoData else { return }
            self.dateLabel.text = convertDateStrToUsefulDateStr(info.createdDate)
            self.customMenuTitleLabel.text = info.name
            self.menuNameLabel.text = info.menuName
            self.mainContainerView.backgroundColor = info.backgroundColor.hexToColor()
            if let url = info.imageUrl {
                self.mainImgView.kf.setImage(with: URL(string: url), placeholder: nil, options: [.cacheMemoryOnly], completionHandler: { [weak self] _ in
                    self?.mainImgView.fadeIn(duration: 0.1, completeHandler: nil)
                })
            }
            
            if let url = info.imageUrl {
                self.menuImgView.kf.setImage(with: URL(string: url), placeholder: nil, options: [.cacheMemoryOnly], completionHandler: { [weak self] _ in
                    self?.menuImgView.fadeIn(duration: 0.1, completeHandler: nil)
                })
            }
            
        }
    }
    
    
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
    
    // MARK: private function
    private func convertDateStrToUsefulDateStr(_ originDataStr: String) -> String {
        var returnValue: String = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSS"
        if let convertDate = dateFormatter.date(from: originDataStr) {
            let myDateFormatter = DateFormatter()
            myDateFormatter.dateFormat = "만든 날짜 : yyyy.MM.dd"
            myDateFormatter.locale = Locale(identifier: "ko_KR")
            returnValue = myDateFormatter.string(from: convertDate)
        }
        return returnValue
    }
    
    
    // MARK: action

}
