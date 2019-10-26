//
//  SceneRow.swift
//  first-demo
//
//  Created by kingcos on 2019/10/26.
//  Copyright © 2019 kingcos. All rights reserved.
//

import SwiftUI

struct SceneRow: View {
    var scene: Scene
    
    var body: some View {
        HStack {
            scene
                .image
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
    static var previews: some View {
        Group {
            SceneRow(scene: sceneData[0])
            SceneRow(scene: sceneData[1])
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
