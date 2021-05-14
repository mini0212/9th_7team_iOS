//
//  MenuCollectionViewCell.swift
//  myRecipick
//
//  Created by Min on 2021/05/14.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell, ClassIdentifiable {

    @IBOutlet weak var lbael: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func label(index: Int) {
        lbael.text = "\(index + 1) 번째"
    }

}
