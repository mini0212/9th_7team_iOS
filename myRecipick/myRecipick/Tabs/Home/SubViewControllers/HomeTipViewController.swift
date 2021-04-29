//
//  HomeTipViewController.swift
//  myRecipick
//
//  Created by hanwe on 2021/04/29.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit

class HomeTipViewController: UIViewController, ClassIdentifiable {
    
    // MARK: IBOutlet
    @IBOutlet weak var backgroundContainerView: UIView!
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var tipContainerView: UIView!
    
    @IBOutlet weak var step1ContainerView: UIView!
    @IBOutlet weak var step1ImgContainerView: UIView!
    @IBOutlet weak var step1TitleLabel: UILabel!
    @IBOutlet weak var step1ContentsLabel: UILabel!
    
    @IBOutlet weak var step2ContainerView: UIView!
    @IBOutlet weak var step2ImgContainerView: UIView!
    @IBOutlet weak var step2TitleLabel: UILabel!
    @IBOutlet weak var step2ContentsLabel: UILabel!
    
    @IBOutlet weak var step3ContainerView: UIView!
    @IBOutlet weak var step3ImgContainerView: UIView!
    @IBOutlet weak var step3TitleLabel: UILabel!
    @IBOutlet weak var step3ContentsLabel: UILabel!
    
    @IBOutlet weak var confirmBtn: UIButton!
    // MARK: property
    
    // MARK: lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    // MARK: function
    
    func initUI() {
        self.backgroundContainerView.backgroundColor = UIColor(asset: Colors.dimmed)
        self.mainContainerView.backgroundColor = .clear
        self.tipContainerView.backgroundColor = UIColor(asset: Colors.white)
        self.tipContainerView.layer.cornerRadius = 24
        
        self.step1ContainerView.backgroundColor = .clear
        self.step1ImgContainerView.layer.cornerRadius = 14
        self.step1ImgContainerView.clipsToBounds = true
        
        self.step1TitleLabel.font = UIFont.myRecipickFont(.subTitle2)
        self.step1TitleLabel.textColor = UIColor(asset: Colors.grayScale33)
        self.step1TitleLabel.text = "Step 1"
        
        self.step1ContentsLabel.font = UIFont.myRecipickFont(.caption)
        self.step1ContentsLabel.textColor = UIColor(asset: Colors.grayScale66)
        self.step1ContentsLabel.text = "원하는 재료를 선택하여 나만의 멋진\n레시피를 만드세요."
        self.step1ContentsLabel.numberOfLines = 2
        
        self.step2ContainerView.backgroundColor = .clear
        self.step2ImgContainerView.layer.cornerRadius = 14
        self.step2ImgContainerView.clipsToBounds = true
        
        self.step2TitleLabel.font = UIFont.myRecipickFont(.subTitle2)
        self.step2TitleLabel.textColor = UIColor(asset: Colors.grayScale33)
        self.step2TitleLabel.text = "Step 2"
        
        self.step2ContentsLabel.font = UIFont.myRecipickFont(.caption)
        self.step2ContentsLabel.textColor = UIColor(asset: Colors.grayScale66)
        self.step2ContentsLabel.text = "커스텀한 메뉴를 매장에서 직접 주문\n해보세요."
        self.step2ContentsLabel.numberOfLines = 2
        
        self.step3ContainerView.backgroundColor = .clear
        self.step3ImgContainerView.layer.cornerRadius = 14
        self.step3ImgContainerView.clipsToBounds = true
        
        self.step3TitleLabel.font = UIFont.myRecipickFont(.subTitle2)
        self.step3TitleLabel.textColor = UIColor(asset: Colors.grayScale33)
        self.step3TitleLabel.text = "Step 3"
        
        self.step3ContentsLabel.font = UIFont.myRecipickFont(.caption)
        self.step3ContentsLabel.textColor = UIColor(asset: Colors.grayScale66)
        self.step3ContentsLabel.text = "친구들에게 자유롭게 공유해보세요."
        self.step3ContentsLabel.numberOfLines = 2
        
        
        
//        
//        @IBOutlet weak var confirmBtn: UIButton!
    }
    
    // MARK: action
    @IBAction func confirmAction(_ sender: Any) {
        print("confirmAction")
    }
    
}
