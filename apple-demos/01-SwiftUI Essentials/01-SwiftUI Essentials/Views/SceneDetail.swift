//
//  SceneDetail.swift
//  01-SwiftUI Essentials
//
//  Created by kingcos on 2020/2/4.
//  Copyright © 2020 kingcos. All rights reserved.
//

import SwiftUI

// 视图结构
struct SceneDetail: View {
    var scene: Scene
    
    var body: some View {
        VStack {
            MapView(coordinate: scene.locationCoordinate)
                .edgesIgnoringSafeArea(.top)
                .frame(height: 300)
            
            CircleImage(image: scene.image)
                .offset(y: -130)
                .padding(.bottom, -130)
            
            VStack(alignment: .leading) {
                Text(scene.name)
                    .font(.title)
                HStack {
                    Text("\(scene.id)")
                        .font(.subheadline)
                    Spacer()
                    Text(scene.state)
                        .font(.subheadline)
                }
            }
            .padding()
            
            Spacer()
        }
        .navigationBarTitle(Text(scene.name), displayMode: .inline)
    }
}

// 便于预览使用 => 点击右侧 Resume 即可预览
struct SceneDetail_Previews: PreviewProvider {
    static var previews: some View {
        SceneDetail(scene: sceneData[0])
    }
}
