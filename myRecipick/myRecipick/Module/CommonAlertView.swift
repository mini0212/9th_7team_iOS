//
//  CommonAlertView.swift
//  myRecipick
//
//  Created by hanwe on 2021/05/01.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit
import SnapKit

class CommonAlertView: UIView {
    // MARK: property
    
    var comfirmHandler: (() -> Void)?
    var cancelHandler: (() -> Void)?
    
    var feedbackGenerator: UINotificationFeedbackGenerator?
    
    // MARK: function
    static let shared: CommonAlertView = {
        let instance = CommonAlertView()
        instance.frame = UIScreen.main.bounds
        let scene = UIApplication.shared.connectedScenes.first
        if let sd: SceneDelegate = (scene?.delegate as? SceneDelegate) {
            instance.isHidden = true
            instance.alpha = 0
            sd.window?.addSubview(instance)
        }
        return instance
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(asset: Colors.dimmed)
        setGenerator()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private struct ScreenSize {
        static let Width = UIScreen.main.bounds.size.width
        static let Height = UIScreen.main.bounds.size.height
        static let Max_Length = max(ScreenSize.Width, ScreenSize.Height)
        static let Min_Length = min(ScreenSize.Width, ScreenSize.Height)
    }
    
    private func setGenerator() {
        self.feedbackGenerator = UINotificationFeedbackGenerator()
        self.feedbackGenerator?.prepare()
    }
    
    func showOneBtnAlert(message: String, messageSurely: [String]? = nil, subMessage: String? = nil, btnText: String, hapticType: UINotificationFeedbackGenerator.FeedbackType? = nil, confirmHandler: @escaping () -> Void) {
        DispatchQueue.main.async {
            self.superview?.bringSubviewToFront(self)
            self.comfirmHandler = confirmHandler
            let buttonView: UIView = UIView()
            buttonView.backgroundColor = .clear
            
            let confirmBtnView: UIView = UIView()
            confirmBtnView.backgroundColor = UIColor(asset: Colors.primaryNormal)
            let confirmBtnLabel: UILabel = UILabel()
            confirmBtnLabel.font = UIFont.myRecipickFont(.subTitle2)
            confirmBtnLabel.textColor = UIColor(asset: Colors.white)
            confirmBtnLabel.textAlignment = .center
            confirmBtnLabel.text = btnText
            confirmBtnView.addSubview(confirmBtnLabel)
            confirmBtnLabel.snp.makeConstraints { (make) in
                make.leading.equalTo(confirmBtnView.snp.leading).offset(0)
                make.trailing.equalTo(confirmBtnView.snp.trailing).offset(0)
                make.centerY.equalTo(confirmBtnView.snp.centerY).offset(0)
            }
            let confirmTaps = UITapGestureRecognizer(target: self, action: #selector(self.confirmAction(_:)))
            confirmBtnView.layer.cornerRadius = 10
            confirmBtnView.addGestureRecognizer(confirmTaps)
            
            buttonView.addSubview(confirmBtnView)
            confirmBtnView.snp.makeConstraints { (make) in
                make.top.equalTo(buttonView.snp.top).offset(0)
                make.bottom.equalTo(buttonView.snp.bottom).offset(0)
                make.leading.equalTo(buttonView.snp.leading).offset(0)
                make.trailing.equalTo(buttonView.snp.trailing).offset(0)
            }
            
            let alertView: UIView = self.makeMainAlertView(message: message, messageSurely: messageSurely, subMessage: subMessage, buttonView: buttonView)
            
            self.addSubview(alertView)
            alertView.snp.makeConstraints { (make) in
                make.centerX.equalTo(self.snp.centerX).offset(0)
                make.centerY.equalTo(self.snp.centerY).offset(0)
                make.width.equalTo(330)
            }
            
            self.isHidden = false
            if hapticType != nil {
                self.feedbackGenerator?.notificationOccurred(hapticType!)
            }
            
            self.fadeIn {
                
            }
        }
    }
    
    private func makeMainAlertView(message: String, messageSurely: [String]? = nil, subMessage: String?, buttonView: UIView) -> UIView {
        
        let alertView: UIView = UIView()
        alertView.backgroundColor = UIColor(asset: Colors.white)
        let messageLabel: UILabel = UILabel()
        messageLabel.font = UIFont.myRecipickFont(.subTitle1)
        if messageSurely == nil {
            messageLabel.text = message
        } else {
            let sumAttString = NSMutableAttributedString(string: message, attributes: [NSAttributedString.Key.font: UIFont.myRecipickFont(.subTitle1) as Any, NSAttributedString.Key.foregroundColor: UIColor(asset: Colors.black) ?? .black])
            for i in 0..<messageSurely!.count {
                let font = UIFont.myRecipickFont(.subTitle2) /* todo 만약 이런거 생기면 바꿔야함 */
                sumAttString.addAttributedStringInSpecificString(targetString: messageSurely![i], attr: [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor(asset: Colors.black) ?? .black])
            }
            messageLabel.attributedText = sumAttString
        }
        
        messageLabel.textAlignment = .center
        messageLabel.textColor = UIColor(asset: Colors.black)
        messageLabel.numberOfLines = 10
        let subMessageLabel: UILabel = UILabel()
        if subMessage != nil {
            subMessageLabel.text = subMessage!
        }
        subMessageLabel.textAlignment = .center
        subMessageLabel.textColor = UIColor(asset: Colors.grayScale99) // 아무거나 넣었음 일단.
        subMessageLabel.numberOfLines = 10
        let buttonContainerView: UIView = UIView()
        buttonContainerView.backgroundColor = .clear
        alertView.addSubview(messageLabel)
        alertView.addSubview(subMessageLabel)
        alertView.addSubview(buttonContainerView)
        alertView.layer.cornerRadius = 24
        alertView.clipsToBounds = true
        
        messageLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(alertView.snp.leading).offset(22)
            make.trailing.equalTo(alertView.snp.trailing).offset(-22)
            make.top.equalTo(alertView.snp.top).offset(59)
        }
        
        if subMessage == nil {
            subMessageLabel.font = UIFont(name: FontKeys.bold, size: 0)
        } else {
            subMessageLabel.font = UIFont.myRecipickFont(.subTitle1) // 아무거나 넣었음
        }
        
        subMessageLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(alertView.snp.leading).offset(22)
            make.trailing.equalTo(alertView.snp.trailing).offset(-22)
            make.top.equalTo(messageLabel.snp.bottom).offset(5) // 적당히 넣음
        }
        
        buttonContainerView.snp.makeConstraints { (make) in
            make.leading.equalTo(alertView.snp.leading).offset(0)
            make.trailing.equalTo(alertView.snp.trailing).offset(0)
            make.top.equalTo(subMessageLabel.snp.bottom).offset(47)
            make.bottom.equalTo(alertView.snp.bottom).offset(-27)
            make.height.equalTo(50)
        }
        
        buttonContainerView.addSubview(buttonView)
        buttonView.snp.makeConstraints { (make) in
            make.top.equalTo(buttonContainerView.snp.top).offset(0)
            make.bottom.equalTo(buttonContainerView.snp.bottom).offset(0)
            make.leading.equalTo(buttonContainerView.snp.leading).offset(24)
            make.trailing.equalTo(buttonContainerView.snp.trailing).offset(-24)
        }
        
        return alertView
    }
    
    func hide(_ completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            self.fadeOut {
                self.removeAllSubview()
                self.isHidden = true
                completion?()
            }
        }
    }
    
    @objc func cancelAction(_ recognizer: UITapGestureRecognizer) {
        self.cancelHandler?()
    }
    @objc func confirmAction(_ recognizer: UITapGestureRecognizer) {
        self.comfirmHandler?()
    }
}
