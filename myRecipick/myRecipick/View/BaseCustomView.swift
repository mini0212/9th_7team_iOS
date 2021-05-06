//
//  BaseCustomView.swift
//  myRecipick
//
//  Created by Min on 2021/05/07.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit

class BaseCustomView: UIView, ClassIdentifiable {

    var containerView: UIView!
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    private func initView() {
        containerView = Bundle.main.loadNibNamed(identifier, owner: self, options: nil)?.first as? UIView
        containerView.frame = bounds
        containerView.backgroundColor = .clear
        addSubview(containerView)
    }
}
