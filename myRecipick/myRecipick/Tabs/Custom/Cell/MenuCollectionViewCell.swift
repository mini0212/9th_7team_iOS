//
//  MenuCollectionViewCell.swift
//  myRecipick
//
//  Created by Min on 2021/05/14.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell, ClassIdentifiable {
    
    let vc: MenuListViewController = {
        let vc = MenuListViewController(nibName: MenuListViewController.identifier, bundle: nil)
        return vc
    }()
    
    private var menuList: [String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initMenuListViewController()
    }
    
    private func initMenuListViewController() {
        contentView.addSubview(vc.view)
        
    }
    
    func menuList(list: [String]?) {
        guard let list = list else { return }
        menuList = list
        print(list)
    }

}
