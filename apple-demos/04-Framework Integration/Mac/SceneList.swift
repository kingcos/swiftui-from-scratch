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
    @State var showFavoritesOnly = false
    
    var filteredScenes: [Scene] {
        userData.scenes.filter { scene in
            (!showFavoritesOnly || scene.isFavorite)
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Favorites only")
                }
                
                ForEach(filteredScenes) { scene in
                    NavigationLink {
                        SceneDetail(scene: scene)
                    } label: {
                        SceneRow(scene: scene)
                    }
                }
            }
            .navigationTitle("Scenes")
            .frame(minWidth: 300)
            .toolbar {
                ToolbarItem {
                    Menu {
                        Toggle(isOn: $showFavoritesOnly) {
                            Label("Favorites only", systemImage: "star.fill")
                        }
                    } label: {
                        Label("Filter", systemImage: "slider.horizontal.3")
                    }
                }
            }
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
