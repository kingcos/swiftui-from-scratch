//
//  SceneRow.swift
//  Mac
//
//  Created by kingcos on 2020/2/6.
//  Copyright © 2020 kingcos. All rights reserved.
//

import SwiftUI

struct SceneRow: View {
    var scene: Scene
    
    var body: some View {
        HStack(alignment: .center) {
            scene.image
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)
                .frame(width: 32, height: 32)
                .fixedSize(horizontal: true, vertical: false)
                .cornerRadius(4.0)
            
            VStack(alignment: .leading) {
                Text(scene.name)
                    .fontWeight(.bold)
                    .truncationMode(.tail)
                    .frame(minWidth: 20)
                
                Text(scene.category.rawValue)
                    .font(.caption)
                    .opacity(0.625)
                    .truncationMode(.middle)
            }
            
            Spacer()
            
            if scene.isFavorite {
                Image("star-filled")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.yellow)
                    .frame(width: 10, height: 10)
            }
        }
        .padding(.vertical, 4)
    }
}

struct SceneRow_Previews: PreviewProvider {
    static var previews: some View {
        SceneRow(scene: sceneData[0])
    }
}
