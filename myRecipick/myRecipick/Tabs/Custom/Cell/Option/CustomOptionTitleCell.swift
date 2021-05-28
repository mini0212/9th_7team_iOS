//
//  CustomOptionTitleCell.swift
//  myRecipick
//
//  Created by Min on 2021/05/21.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CustomOptionTitleCell: UICollectionViewCell, ClassIdentifiable {

    @IBOutlet weak var contentsView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var optionLabel: UILabel!
    @IBOutlet weak var arrowImageView: UIImageView!
    
    var tapObservable: Observable<Void> {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tabAction))
        contentsView.addGestureRecognizer(tapGesture)
        return tapGesture.rx.event.map { _ in () }
    }
    var disposeBag = DisposeBag()
    
    // Configure
    var section: OptionSection? = nil {
        didSet {
            disposeBag = DisposeBag()
            titleLabel.text = section?.option.name
            optionLabel.text = nil
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initLabels()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    private func initLabels() {
        titleLabel.text = nil
        titleLabel.font = .myRecipickFont(.subTitle2)
        titleLabel.textColor = Colors.grayScale33.color
        
        optionLabel.text = nil
        optionLabel.font = .myRecipickFont(.caption)
        optionLabel.textColor = Colors.primaryNormal.color
        optionLabel.isHidden = true
        
        arrowImageView.image = Images.iconsNavigation24ArrowClose.image.withRenderingMode(.alwaysTemplate)
        arrowImageView.tintColor = Colors.grayScale99.color
        
    }
    
    @objc private func tabAction() {
//        UIView.animate(withDuration: 0.5) {
//            self.arrowImageView.transform = self.arrowImageView.transform.rotated(by: .pi)
//
//        }
    }
}
