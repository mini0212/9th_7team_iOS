//
//  BrandSelectCollectionViewCell.swift
//  myRecipick
//
//  Created by hanwe on 2021/05/22.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit

class BrandSelectCollectionViewCell: UICollectionViewCell, ClassIdentifiable {

    // MARK: IBOutlet
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var contentsLabel: UILabel!
    
    // MARK: property
    
    var infoData: BrandObjectModel? {
        didSet {
            guard let info = self.infoData else {
                return
            }
            self.imageContainerView.layer.borderWidth = 1
            self.imageContainerView.layer.borderColor = UIColor(asset: Colors.grayScaleEE)?.cgColor
            self.contentsLabel.text = info.name
            self.imgView.kf.setImage(with: URL(string: info.logoImgUrl), placeholder: Images.sample.image, options: [.cacheMemoryOnly], completionHandler: { [weak self] _ in
                self?.imgView.fadeIn(duration: 0.1, completeHandler: nil)
            })
        }
    }
    
    // MARK: lifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }
    
    func initUI() {
        self.mainContainerView.backgroundColor = .clear
        self.contentsLabel.font = UIFont.myRecipickFont(.body2)
        self.contentsLabel.textColor = UIColor(asset: Colors.grayScale66)
        self.imgView.alpha = 0
    }
    
    // MARK: function
    
    // MARK: action

}
