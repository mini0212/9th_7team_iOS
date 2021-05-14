//
//  MenuCategoryBar.swift
//  myRecipick
//
//  Created by Min on 2021/05/14.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit
import SnapKit

protocol MenuCategoryBarDelegate: AnyObject {
    func tapTabbar(scrollTo index: Int)
}

class MenuCategoryBar: BaseCustomView {
    
    @IBOutlet weak var tabbarCollectionView: UICollectionView!
    
    var indicatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.primaryNormal.color
        return view
    }()
    
    var indicatorViewLeadingConstraint: NSLayoutConstraint!
    var indicatorViewWidthConstraint: NSLayoutConstraint!
    
    var menuList: [String] = [] {
        didSet {
            tabbarCollectionView.reloadData()
            let indexPath = IndexPath(item: 0, section: 0)
            tabbarCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
        }
    }
    
    weak var delegate: MenuCategoryBarDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        initTabBar()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initTabBar()
    }
    
    private func initTabBar() {
        initCollectionView()
        addSubview(indicatorView)
        indicatorView.snp.updateConstraints { snp in
            snp.height.equalTo(2)
            snp.width.equalTo((self.frame.width / 4) - 24)
            snp.leading.equalTo(self.snp.leading).offset(12 + 12)
            snp.bottom.equalTo(self.snp.bottom)
        }
    }
    
    private func initCollectionView() {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .horizontal
        tabbarCollectionView.collectionViewLayout = collectionViewFlowLayout
        tabbarCollectionView.register(UINib(nibName: MenuCategoryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: MenuCategoryCollectionViewCell.identifier)
    }
    
    func moveIndicator(in index: Int) {
        indicatorView.snp.updateConstraints { snp in
            snp.leading.equalTo(self.snp.leading).offset((Int(self.frame.width) / 4) * index + 12 + 12)
        }
        UIView.animate(withDuration: 0.25) {
            self.layoutIfNeeded()
        }
    }
}

extension MenuCategoryBar: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCategoryCollectionViewCell.identifier, for: indexPath) as? MenuCategoryCollectionViewCell else { return UICollectionViewCell() }
        let item = menuList[indexPath.row]
        cell.bind(item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width / 4, height: 55)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        moveIndicator(in: indexPath.row)
        delegate?.tapTabbar(scrollTo: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? MenuCategoryCollectionViewCell else {return}
        cell.titleLabel.textColor = Colors.grayScale66.color
    }
}

extension MenuCategoryBar: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MenuCategoryBar: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
