//
//  CustomOptionSubTitleCell.swift
//  myRecipick
//
//  Created by Min on 2021/05/21.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit

class CustomOptionSubTitleCell: UICollectionViewCell, ClassIdentifiable {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var questionImageView: UIImageView!
    
    
    override var isSelected: Bool {
        didSet {
            titleLabel.textColor = isSelected ? Colors.primaryNormal.color : Colors.grayScale66.color
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        imageView.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initLabel()
    }
    
    private func initLabel() {
        titleLabel.text = nil
        titleLabel.textColor = Colors.grayScale66.color
        titleLabel.font = .myRecipickFont(.body2)
    }
    
    func bind(item: OptionModel) {
        titleLabel.text = item.name
        switch item.type {
        case .check:
            imageView.image = Images.uncheckBox.image
            imageView.highlightedImage = Images.checkBox.image
        case .radio:
            imageView.image = Images.editNonCheck.image
            imageView.highlightedImage = Images.editCheck.image
        default: break
        }
    }
}
