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
    @EnvironmentObject var userData: UserData
    
    var scene: Scene
    
    var sceneIndex: Int {
        userData.sceneData.firstIndex(where: { $0.id == scene.id })!
    }
    
    var body: some View {
        ScrollView {
            MapView(coordinate: scene.locationCoordinate)
                .edgesIgnoringSafeArea(.top)
                .frame(height: 300)
            
            CircleImage(image: scene.image)
                .offset(y: -130)
                .padding(.bottom, -130)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(scene.name)
                        .font(.title)
                    FavoriteButton(isSet: $userData.sceneData[sceneIndex].isFavorite)
                }

                HStack {
                    Text("\(scene.id)")
                    Spacer()
                    Text(scene.state)
                }
                .font(.subheadline)
                .foregroundColor(.secondary)

                Divider()

                Text("关于\(scene.name)")
                    .font(.title2)
                Text("描述：\(scene.description)")
                
                
//                HStack {
//
//                    Button(action: {
//                        self.userData.scenes[self.sceneIndex].isFavorite.toggle()
//                    }) {
//                        if self.userData.scenes[self.sceneIndex].isFavorite {
//                            Image(systemName: "star.fill")
//                                .foregroundColor(Color.yellow)
//                        } else {
//                            Image(systemName: "star")
//                                .foregroundColor(Color.gray)
//                        }
//                    }
//                }
//
//                HStack {
//                    Text("\(scene.id)")
//                        .font(.subheadline)
//                    Spacer()
//                    Text(scene.state)
//                        .font(.subheadline)
//                }
            }
            .padding()
            
            Spacer()
        }
        .navigationTitle(scene.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// 便于预览使用 => 点击右侧 Resume 即可预览
struct SceneDetail_Previews: PreviewProvider {
    static let userData = UserData()
    
    static var previews: some View {
        SceneDetail(scene: userData.sceneData[0])
            .environmentObject(userData)
    }
}
