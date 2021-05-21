//
//  UIScrollView + Snapshot.swift
//  myRecipick
//
//  Created by hanwe on 2021/04/14.
//  Copyright © 2021 depromeet. All rights reserved.
//

import UIKit

extension UIView {
    func snapshot(scrollView: UIScrollView, extraHeight: CGFloat) -> UIImage? {
        let scrollViewHeight: CGFloat = scrollView.contentSize.height
        UIGraphicsBeginImageContextWithOptions(CGSize(width: self.frame.width, height: scrollViewHeight + extraHeight), false, UIScreen.main.scale)
        let savedContentOffset = scrollView.contentOffset
        let savedFrame = self.frame
        let savedBackgroundColor = self.backgroundColor
        scrollView.contentOffset = CGPoint(x: 0, y: -extraHeight)
        self.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: scrollViewHeight + extraHeight)

        let tempView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: scrollViewHeight + extraHeight))

        let tempSuperView = self.superview
        self.removeFromSuperview()
        tempView.addSubview(self)

        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        tempView.layer.render(in: context)
        guard let image: UIImage = UIGraphicsGetImageFromCurrentImageContext() else { return nil }

        tempView.subviews[0].removeFromSuperview()
        if let superView = tempSuperView {
            superView.addSubview(self)
        }

        scrollView.contentOffset = savedContentOffset
        self.frame = savedFrame
        self.backgroundColor = savedBackgroundColor

        UIGraphicsEndImageContext()

        return image
    }
}
