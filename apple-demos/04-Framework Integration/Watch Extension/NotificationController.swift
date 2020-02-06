//
//  NotificationController.swift
//  Watch Extension
//
//  Created by kingcos on 2020/2/6.
//  Copyright © 2020 kingcos. All rights reserved.
//

import WatchKit
import SwiftUI
import UserNotifications

class NotificationController: WKUserNotificationHostingController<NotificationView> {
    var scene: Scene?
    var title: String?
    var message: String?

    let sceneIndexKey = "sceneIndex"
    
    override var body: NotificationView {
        return NotificationView(title: title, message: message, scene: scene)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    override func didReceive(_ notification: UNNotification) {
        // This method is called when a notification needs to be presented.
        // Implement it if you use a dynamic notification interface.
        // Populate your dynamic notification interface as quickly as possible.
        let userData = UserData()
        
        let notificationData =
            notification.request.content.userInfo as? [String: Any]
        
        let aps = notificationData?["aps"] as? [String: Any]
        let alert = aps?["alert"] as? [String: Any]
        
        title = alert?["title"] as? String
        message = alert?["body"] as? String
        
        if let index = notificationData?[sceneIndexKey] as? Int {
            scene = userData.scenes[index]
        }
    }
}
