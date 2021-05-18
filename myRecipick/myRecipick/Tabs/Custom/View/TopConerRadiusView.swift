//
//  TopConerRadiusView.swift
//  myRecipick
//
//  Created by hanwe on 2021/05/18.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit

class TopConerRadiusView: UIView {

    override func layoutSubviews() {
        super.layoutSubviews()
        self.roundCorners(corners: [.topLeft, .topRight], radius: 25)
    }

}
