//
//  ContentView.swift
//  03-App Design and Layout
//
//  Created by kingcos on 2020/2/4.
//  Copyright © 2020 kingcos. All rights reserved.
//

import SwiftUI

struct ContentView: View {
//    var scene: Scene
    
    @State private var selection: Tab = .featured
    
    enum Tab {
        case featured
        case list
    }

    var body: some View {
        TabView(selection: $selection) {
            CategoryHome()
                .tabItem {
                    Label("Featured", systemImage: "star")
                }
                .tag(Tab.featured)

            SceneList()
                .tabItem {
                    Label("List", systemImage: "list.bullet")
                }
                .tag(Tab.list)
        }
        
//        VStack {
//            MapView(coordinate: scene.locationCoordinate)
//                .edgesIgnoringSafeArea(.top)
//                .frame(height: 300)
//
//            CircleImage(image: scene.image)
//                .offset(y: -130)
//                .padding(.bottom, -130)
//
//            VStack(alignment: .leading) {
//                Text(scene.name)
//                    .font(.title)
//                HStack(alignment: .top) {
//                    Text("\(scene.id)")
//                        .font(.subheadline)
//                    Spacer()
//                    Text(scene.state)
//                        .font(.subheadline)
//                }
//            }
//            .padding()
//
//            Spacer()
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//        ContentView(scene: ModelData().sceneData[0])
        ContentView()
            .environmentObject(ModelData())
    }
}
