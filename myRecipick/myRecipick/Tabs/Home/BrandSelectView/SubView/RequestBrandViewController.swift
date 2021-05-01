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
    
    var originMainContainerViewBottomConstraint: CGFloat = 0
    
    // MARK: lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItems()
        initUI()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: function
    
    func initUI() {
        
        self.backgroundContainerView.backgroundColor = UIColor(asset: Colors.white)
        self.mainContainerView.backgroundColor = .clear
        
        self.scrollView.backgroundColor = .clear
        
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
        self.textField.returnKeyType = .done
        self.textField.delegate = self
        
        
        self.requestBtn.adjustsImageWhenHighlighted = false
        self.requestBtn.showsTouchWhenHighlighted = false
        self.requestBtn.setBackgroundColor(UIColor(asset: Colors.primaryNormal) ?? .orange, for: .normal)
        self.requestBtn.setBackgroundColor(UIColor(asset: Colors.primaryDark) ?? .orange, for: .highlighted)
        self.requestBtn.setTitle("제출", for: .normal)
        self.requestBtn.setTitleColor(.white, for: .normal)
        self.requestBtn.titleLabel?.font = UIFont.myRecipickFont(.subTitle2)
        self.requestBtn.layer.cornerRadius = 10
        self.requestBtn.layer.masksToBounds = true
        
    }
    
    func setNavigationItems() {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor(asset: Colors.navigationTitle)
        titleLabel.font = UIFont.myRecipickFont(.subTitle1)
        titleLabel.text = "브랜드 추가 요청"
        self.navigationItem.titleView = titleLabel
        self.navigationItem.rightBarButtonItem = nil
        let imgIcon = UIImage(named: "iconsNavigation24ArrowLeft")?.withRenderingMode(.alwaysOriginal)
        let barButtonItem = UIBarButtonItem(image: imgIcon, style: .plain, target: self, action: #selector(popButtonClicked(_:)))
        self.navigationItem.leftBarButtonItem = barButtonItem
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardHeight = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height else { return }
        self.mainContainerViewBottomConstraint.constant = keyboardHeight
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        self.mainContainerViewBottomConstraint.constant = self.originMainContainerViewBottomConstraint
        UIView.animate(withDuration: 1.0, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func requestNewBrandQuery(completeHandler: @escaping () -> Void, failureHandler: @escaping () -> Void) {
        print("todo requestNewBrandQuery")
        completeHandler()
    }
    
    // MARK: action
    @IBAction func requestAction(_ sender: Any) {
        print("requestAction")
        self.navigationController?.popViewController(animated: true)
        // todo loading start
        requestNewBrandQuery(completeHandler: {
            // todo loading end
            
        }, failureHandler: {
            // todo loading end
            // todo alert?
        })
    }
    
    @objc func popButtonClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        // todo loading start
        requestNewBrandQuery(completeHandler: {
            // todo loading end
            
        }, failureHandler: {
            // todo loading end
            // todo alert?
        })
    }

}


extension RequestBrandViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textField.endEditing(true)
        return true
    }
}
