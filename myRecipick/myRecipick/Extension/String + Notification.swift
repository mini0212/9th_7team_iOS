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
        case .customMenuRemoved:
            return "CUSTOM_MENU_REMOVED"
        }
    }
    
    case customMenuRemoved
}

extension String {
    static func myRecipickNotificationName(_ name: NotificationNameDefineEnum) -> String {
        var returnValue: String = ""
        switch name {
        case .customMenuRemoved:
            returnValue = name.description
        }
        return returnValue
    }
}
