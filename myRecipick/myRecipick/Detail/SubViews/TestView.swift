//
//  TestView.swift
//  myRecipick
//
//  Created by hanwe lee on 2021/05/06.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit

class TestView: UIView {

    override func layoutSubviews() {
        print("111")
        super.layoutSubviews()
        print("222:\(self.bounds.height)")
    }

}
