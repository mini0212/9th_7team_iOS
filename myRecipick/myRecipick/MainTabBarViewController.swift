//
//  MainTabBarViewController.swift
//  myRecipick
//
//  Created by hanwe on 2021/04/19.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit
import SnapKit

class MainTabBarViewController: UITabBarController {
    
    // MARK: outlet
    
    // MARK: property
    
    var attachedViewPool: [UIView] = []
    
    // MARK: lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    // MARK: func
    
    func initUI() {
        
    }
    
    func attachSubView(_ attachedView: UIView) {
        attachedViewPool.append(attachedView)
        self.view.addSubview(attachedView)
        attachedView.snp.makeConstraints { (make) in
            make.leading.equalTo(self.view.snp.leading)
            make.trailing.equalTo(self.view.snp.trailing)
            make.bottom.equalTo(self.view.snp.bottom)
            make.height.equalTo(self.tabBar.frame.height)
        }
    }
    
    func detachAllSubView() {
        for i in 0..<self.attachedViewPool.count {
            self.attachedViewPool[i].removeFromSuperview()
        }
        self.attachedViewPool.removeAll()
    }
    
    // MARK: action

    
    
    

}
