//
//  DetailViewController.swift
//  myRecipick
//
//  Created by hanwe lee on 2021/05/04.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    // MARK: outlet
    @IBOutlet weak var backgroundContainerView: UIView!
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topContentsContainerView: UIView!
    @IBOutlet weak var mainImgView: UIImageView!
    @IBOutlet weak var customMenuTitleLabel: UILabel!
    @IBOutlet weak var menuContainerView: UIView!
    @IBOutlet weak var menuImgView: UIImageView!
    @IBOutlet weak var menuTitleLabel: UILabel!
    @IBOutlet weak var ingredientsContainerView: UIView!
    @IBOutlet weak var ingredientsHeightConstraint: NSLayoutConstraint!
    
    // MARK: property
    
    // MARK: lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    // MARK: func
    
    func initUI() {
        self.backgroundContainerView.backgroundColor = UIColor(asset: Colors.white)
        self.mainContainerView.backgroundColor = .clear
        self.tableView.dataSource = self
        self.topContentsContainerView.backgroundColor = .clear
        self.customMenuTitleLabel.font = UIFont.myRecipickFont(.detailMenuTitle)
        self.customMenuTitleLabel.textColor = UIColor(asset: Colors.white)
        self.menuContainerView.backgroundColor = UIColor(asset: Colors.white)
        self.menuContainerView.layer.cornerRadius = 20
        self.menuTitleLabel.font = UIFont.myRecipickFont(.yourRecipe)
        self.menuTitleLabel.textColor = UIColor(asset: Colors.grayScale33)
        self.ingredientsContainerView.backgroundColor = .clear
        
    }
    
    // MARK: action

}


extension DetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
