//
//  ContentView.swift
//  first-demo
//
//  Created by kingcos on 2019/10/26.
//  Copyright © 2019 kingcos. All rights reserved.
//

import SwiftUI

// 视图结构
struct SceneDetail: View {
    @EnvironmentObject var userData: UserData
    var scene: Scene
    
    var sceneIndex: Int {
        userData.scenes.firstIndex(where: { $0.id == scene.id })!
    }
    
    var body: some View {
        // body 内只能有一个元素
        VStack {
            MapView(coordinate: scene.locationCoordinate)
                .frame(height: 300.0)
                .edgesIgnoringSafeArea(.top)
            
            CircleImage(image: scene.image)
                .offset(y: -210)
                .padding(.bottom, -210)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(scene.name)
                        .font(.title) // 这样的方法被称之为 modifiers（修饰器）
                    Button(action: {
                        self.userData.scenes[self.sceneIndex].isFavorite.toggle()
                    }) {
                        if self.userData.scenes[self.sceneIndex].isFavorite {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                        } else {
                            Image(systemName: "star")
                                .foregroundColor(.gray)
                        }
                    }
                }
                HStack {
                    Text(scene.state)
                        .font(.subheadline)
                    Spacer() // 间隔
                    Text(scene.category.rawValue)
                        .font(.subheadline)
                }
            }
            .padding() // 内边距
            
            Spacer()
        }
        .navigationBarTitle(Text(scene.name), displayMode: .inline)
    }
}

// 便于预览使用 => 点击右侧 Resume 即可预览
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SceneDetail(scene: sceneData[0])
    }
}
