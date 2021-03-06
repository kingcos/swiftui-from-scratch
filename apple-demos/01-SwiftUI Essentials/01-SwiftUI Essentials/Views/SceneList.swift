//
//  SceneList.swift
//  01-SwiftUI Essentials
//
//  Created by kingcos on 2020/2/4.
//  Copyright © 2020 kingcos. All rights reserved.
//

import SwiftUI

struct SceneList: View {
    @EnvironmentObject var userData: UserData
    // @State var showFavoritesOnly = true
    
    var body: some View {
        NavigationView {
            List {
                Toggle(isOn: $userData.showFavoritesOnly) {
                    Text("Favorites only")
                }

                ForEach(userData.scenes) { scene in
                    if !self.userData.showFavoritesOnly || scene.isFavorite {
                        NavigationLink(destination: SceneDetail(scene: scene)) {
                            SceneRow(scene: scene)
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Scenes"))
        }
    }
}

struct SceneList_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SceneList()
                .environmentObject(UserData())
                .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
            
            ForEach(["iPhone SE", "iPhone XS Max"], id: \.self) { deviceName in
                SceneList()
                    .environmentObject(UserData())
                    .previewDevice(PreviewDevice(rawValue: deviceName))
                    .previewDisplayName(deviceName)
            }
        }
    }
}
