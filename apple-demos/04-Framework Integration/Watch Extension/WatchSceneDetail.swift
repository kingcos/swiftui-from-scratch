//
//  WatchSceneDetail.swift
//  Watch Extension
//
//  Created by kingcos on 2020/2/6.
//  Copyright © 2020 kingcos. All rights reserved.
//

import SwiftUI

struct SceneDetail: View {
    @EnvironmentObject var userData: UserData
    
    var scene: Scene
    
    var sceneIndex: Int {
        userData.scenes.firstIndex(where: { $0.id == scene.id })!
    }
    
    var body: some View {
        ScrollView {
            VStack {
                CircleImage(image: scene.image.resizable())
                    .scaledToFit()

                Text(scene.name)
                    .font(.headline)
                    .lineLimit(0)

                Toggle(isOn: $userData.scenes[sceneIndex].isFavorite) {
                    Text("Favorite")
                }

                Divider()

                Text(scene.category.rawValue)
                    .font(.caption)
                    .bold()
                    .lineLimit(0)

                Text(scene.state)
                    .font(.caption)

                Divider()

                MapView(coordinate: scene.locationCoordinate)
                    .scaledToFit()
            }
            .padding(16)
        }
        .navigationTitle("Scenes")
    }
}

struct SceneDetail_Previews: PreviewProvider {
    static var previews: some View {
        let userData = UserData()
        
        return Group {
            SceneDetail(scene: userData.scenes[0]).environmentObject(userData)
                .previewDevice("Apple Watch Series 4 - 44mm")
            
            SceneDetail(scene: userData.scenes[1]).environmentObject(userData)
                .previewDevice("Apple Watch Series 2 - 38mm")
        }
    }
}
