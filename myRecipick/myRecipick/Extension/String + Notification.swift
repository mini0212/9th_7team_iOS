//
//  String + Notification.swift
//  myRecipick
//
//  Created by hanwe on 2021/05/30.
//  Copyright © 2021 depromeet. All rights reserved.
//

enum NotificationNameDefineEnum: CustomStringConvertible {
    var description: String {
        switch self {
        case .customMenuAdded:
            return "CUSTOM_MENU_ADDED"
        case .customMenuRemoved:
            return "CUSTOM_MENU_REMOVED"
        }
    }
    case customMenuAdded
    case customMenuRemoved
    
}

extension String {
    static func myRecipickNotificationName(_ name: NotificationNameDefineEnum) -> String {
        return name.description
    }
}
