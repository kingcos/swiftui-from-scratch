//
//  NotificationView.swift
//  Watch Extension
//
//  Created by kingcos on 2020/2/6.
//  Copyright © 2020 kingcos. All rights reserved.
//

import SwiftUI

struct NotificationView: View {
    let title: String?
    let message: String?
    let scene: Scene?
    
    init(title: String? = nil,
         message: String? = nil,
         scene: Scene? = nil) {
        self.title = title
        self.message = message
        self.scene = scene
    }
    
    var body: some View {
        VStack {
            
            if scene != nil {
                CircleImage(image: scene!.image.resizable())
                    .scaledToFit()
            }
            
            Text(title ?? "Unknown Scene")
                .font(.headline)
                .lineLimit(0)
            
            Divider()
            
            Text(message ?? "You are within 5 miles of one of your favorite scenes.")
                .font(.caption)
                .lineLimit(0)
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NotificationView()
            
            NotificationView(title: "长城",
                             message: "万里长城",
                             scene: UserData().scenes[0])
        }
    }
}
