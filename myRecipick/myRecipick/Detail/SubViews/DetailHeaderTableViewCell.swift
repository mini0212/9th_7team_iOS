//
//  DetailHeaderTableViewCell.swift
//  myRecipick
//
//  Created by hanwe on 2021/05/18.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit

class DetailHeaderTableViewCell: UITableViewCell, ClassIdentifiable {

    // MARK: IBOutlet
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: property
    
    var isFold: Bool = false {
        didSet {
            if self.isFold {
                
            } else {
                
            }
        }
    }
    
    // MARK: lifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: function
    
    func initUI() {
        self.mainContainerView.layer.masksToBounds = true
        self.mainContainerView.backgroundColor = UIColor(asset: Colors.white)
        self.titleLabel.font = UIFont.myRecipickFont(.title4)
        self.titleLabel.textColor = UIColor(asset: Colors.grayScale33)
        self.titleLabel.text = "상세 보기"
    }
    
    // MARK: action
    @IBAction func FoldBtnAction(_ sender: Any) {
        
    }
}
