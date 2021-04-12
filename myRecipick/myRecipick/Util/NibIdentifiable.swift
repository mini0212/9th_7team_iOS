//
//  NibIdentifiable.swift
//  myRecipick
//
//  Created by Min on 2021/04/12.
//

import UIKit

protocol NibIdentifiable: AnyObject {
    static var nib: UINib { get }
}

extension NibIdentifiable {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
}
