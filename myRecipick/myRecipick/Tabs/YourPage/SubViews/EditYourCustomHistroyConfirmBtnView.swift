//
//  EditYourCustomHistroyConfirmBtnView.swift
//  myRecipick
//
//  Created by hanwe lee on 2021/05/04.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit

protocol EditYourCustomHistroyConfirmBtnViewDelegate: AnyObject {
    func checkedItemDeleteBtnClicked()
}

class EditYourCustomHistroyConfirmBtnView: UIView, NibIdentifiable {
    
    // MARK: outlet
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var confrimBtnView: UIButton!
    
    // MARK: property
    
    weak var delegate: EditYourCustomHistroyConfirmBtnViewDelegate?
    
    // MARK: lifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }
    
    deinit {
        print("- \(type(of: self)) deinit")
    }
    
    // MARK: func
    class func instance() -> EditYourCustomHistroyConfirmBtnView? {
        return EditYourCustomHistroyConfirmBtnView.nib.instantiate(withOwner: nil, options: nil).first as? EditYourCustomHistroyConfirmBtnView
    }
    
    func initUI() {
        self.mainContainerView.backgroundColor = UIColor(asset: Colors.white)
        
        self.confrimBtnView.adjustsImageWhenHighlighted = false
        self.confrimBtnView.showsTouchWhenHighlighted = false
        self.confrimBtnView.setBackgroundColor(UIColor(asset: Colors.primaryNormal) ?? .orange, for: .normal)
        self.confrimBtnView.setBackgroundColor(UIColor(asset: Colors.primaryDark) ?? .orange, for: .highlighted)
        self.confrimBtnView.setTitle("제출", for: .normal)
        self.confrimBtnView.setTitleColor(.white, for: .normal)
        self.confrimBtnView.titleLabel?.font = UIFont.myRecipickFont(.subTitle2)
        self.confrimBtnView.layer.cornerRadius = 10
        self.confrimBtnView.layer.masksToBounds = true
    }
    
    // MARK: action
    @IBAction func confirmAction(_ sender: Any) {
        self.delegate?.checkedItemDeleteBtnClicked()
    }
    
}
