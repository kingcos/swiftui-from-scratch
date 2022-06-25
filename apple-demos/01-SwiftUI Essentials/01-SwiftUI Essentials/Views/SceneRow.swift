//
//  SceneRow.swift
//  01-SwiftUI Essentials
//
//  Created by kingcos on 2020/2/4.
//  Copyright © 2020 kingcos. All rights reserved.
//

import SwiftUI

struct SceneRow: View {
    var scene: Scene
    
    var body: some View {
        HStack {
            scene.image
                .resizable()
                .frame(width: 50, height: 50)
            Text(scene.name)
            Spacer()
            
            if scene.isFavorite {
                Image(systemName: "star.fill")
                    .imageScale(.medium)
                    .foregroundColor(.yellow)
            }
        }
    }
}

struct SceneRow_Previews: PreviewProvider {
    static var scenes = UserData().sceneData
    
    static var previews: some View {
        Group {
            SceneRow(scene: scenes[0])
                // .previewLayout(.fixed(width: 300, height: 70))
            SceneRow(scene: scenes[1])
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
