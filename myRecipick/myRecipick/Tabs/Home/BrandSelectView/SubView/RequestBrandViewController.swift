//
//  RequestBrandViewController.swift
//  myRecipick
//
//  Created by hanwe on 2021/04/30.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit

class RequestBrandViewController: UIViewController, ClassIdentifiable {

    // MARK: IBOutlet
    @IBOutlet weak var backgroundContainerView: UIView!
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var mainContainerViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentsContainerView: UIView!
    @IBOutlet weak var centerContainerView: UIView!
    @IBOutlet weak var centerTitleLabel: UILabel!
    @IBOutlet weak var textFieldContainerView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var requestBtn: UIButton!
    
    // MARK: property
    
    // MARK: lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    // MARK: function
    
    func initUI() {
        
        self.backgroundContainerView.backgroundColor = UIColor(asset: Colors.white)
        self.mainContainerView.backgroundColor = .clear
        
        self.scrollView.backgroundColor = .clear
        self.scrollView.delegate = self
        
        
        self.contentsContainerView.backgroundColor = .clear
        self.centerContainerView.backgroundColor = .clear
        self.centerTitleLabel.font = UIFont.myRecipickFont(.title3)
        self.centerTitleLabel.textColor = UIColor(asset: Colors.grayScale33)
        self.centerTitleLabel.text = "추가로 커스텀 하고 싶으신\n브랜드가 있다면 적어주세요!"
        self.centerTitleLabel.numberOfLines = 2
        self.textFieldContainerView.layer.cornerRadius = 8
        self.textFieldContainerView.backgroundColor = UIColor(asset: Colors.grayScaleF7)
        self.textField.font = UIFont.myRecipickFont(.subTitle2)
        self.textField.textColor = UIColor(asset: Colors.black)
        self.textField.placeholder = "여기에 입력"
        
        
        self.requestBtn.adjustsImageWhenHighlighted = false
        self.requestBtn.showsTouchWhenHighlighted = false
        self.requestBtn.setBackgroundColor(UIColor(asset: Colors.primaryNormal) ?? .orange, for: .normal)
        self.requestBtn.setBackgroundColor(UIColor(asset: Colors.primaryDark) ?? .orange, for: .highlighted)
        self.requestBtn.setTitle("제출", for: .normal)
        self.requestBtn.setTitleColor(.white, for: .normal)
        self.requestBtn.titleLabel?.font = UIFont.myRecipickFont(.subTitle2)
        
    }
    
    // MARK: action
    @IBAction func requestAction(_ sender: Any) {
        print("requestAction")
    }
    

}

extension RequestBrandViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}
