//
//  WatchSceneDetail.swift
//  Watch Extension
//
//  Created by kingcos on 2020/2/6.
//  Copyright © 2020 kingcos. All rights reserved.
//

import SwiftUI

struct WatchSceneDetail: View {
    @EnvironmentObject var userData: UserData
    
    var scene: Scene
    
    var sceneIndex: Int {
        userData.scenes.firstIndex(where: { $0.id == scene.id })!
    }
    
    var body: some View {
        ScrollView {
            VStack {
                CircleImage(image: self.scene.image.resizable())
                    .scaledToFit()
                
                Text(self.scene.name)
                    .font(.headline)
                    .lineLimit(0)
                
                Toggle(isOn:
                $userData.scenes[self.sceneIndex].isFavorite) {
                    Text("Favorite")
                }
                
                Divider()
                
                Text(self.scene.category.rawValue)
                    .font(.caption)
                    .bold()
                    .lineLimit(0)
                
                Text(self.scene.state)
                    .font(.caption)
                
                Divider()
                
                WatchMapView(scene: self.scene)
                    .scaledToFit()
                    .padding()
            }
            .padding(16)
        }
        .navigationBarTitle("Scenes")
    }
}

struct WatchSceneDetail_Previews: PreviewProvider {
    static var previews: some View {
        let userData = UserData()
        
        return Group {
            WatchSceneDetail(scene: userData.scenes[0]).environmentObject(userData)
                .previewDevice("Apple Watch Series 4 - 44mm")
            
            WatchSceneDetail(scene: userData.scenes[1]).environmentObject(userData)
                .previewDevice("Apple Watch Series 2 - 38mm")
        }
    }
}
