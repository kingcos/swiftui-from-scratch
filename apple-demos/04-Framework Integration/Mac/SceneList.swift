//
//  SceneList.swift
//  Mac
//
//  Created by kingcos on 2020/2/6.
//  Copyright © 2020 kingcos. All rights reserved.
//

import SwiftUI

struct SceneList: View {
    @EnvironmentObject private var userData: UserData
    @Binding var selectedScene: Scene?
    @Binding var filter: FilterType
    
    var body: some View {
        List(selection: $selectedScene) {
            ForEach(userData.scenes) { scene in
                if (!self.userData.showFavoritesOnly || scene.isFavorite)
                    && (self.filter == .all
                        || self.filter.category == scene.category
                        || (self.filter.category == .history && scene.isFeatured)) {
                    SceneRow(scene: scene).tag(scene)
                }
            }
        }
    }
}

struct SceneList_Previews: PreviewProvider {
    static var previews: some View {
        SceneList(selectedScene: .constant(sceneData[0]),
                  filter: .constant(.all))
            .environmentObject(UserData())
    }
}
