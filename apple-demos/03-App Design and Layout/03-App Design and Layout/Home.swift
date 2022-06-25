//
//  Home.swift
//  03-App Design and Layout
//
//  Created by kingcos on 2020/2/5.
//  Copyright © 2020 kingcos. All rights reserved.
//

import SwiftUI

struct CategoryHome: View {
    @EnvironmentObject var modelData: ModelData
    @State private var showingProfile = false
    
    var featured: [Scene] {
        modelData.sceneData.filter { $0.isFavorite }
    }
    
    var profileButton: some View {
        Button(action: { self.showingProfile.toggle() }) {
            Image(systemName: "person.crop.circle")
                .imageScale(.large)
                .accessibility(label: Text("User Profile")) // 无障碍
                .padding()
        }
    }
    
    var body: some View {
        NavigationView {
            List {
//                FeaturedScenes(scenes: featured)
//                    .scaledToFill()
//                    .frame(height: 200)
//                    .clipped()
//                    .listRowInsets(EdgeInsets())
                modelData.features[0].image
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .clipped()
                    .listRowInsets(EdgeInsets())
                
                ForEach(modelData.categories.keys.sorted(), id: \.self) { key in
                    CategoryRow(categoryName: key, items: modelData.categories[key]!)
                }
                .listRowInsets(EdgeInsets())
                
                NavigationLink(destination: SceneList()) {
                    Text("See All")
                }
            }
            .listStyle(.inset)
//            .navigationBarTitle(Text("Featured"))
            .navigationBarTitle("Featured")
            .toolbar {
                Button {
                    showingProfile.toggle()
                } label: {
                    Label("User Profile", systemImage: "person.crop.circle")
                }
            }
            .sheet(isPresented: $showingProfile) {
                ProfileHost()
                    .environmentObject(modelData) // 注入
            }
//            .navigationBarItems(trailing: profileButton)
        }
    }
}

struct CategoryHome_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHome()
            .environmentObject(ModelData())
    }
}

struct FeaturedScenes: View {
    var scenes: [Scene]
    
    var body: some View {
        scenes[0].image.resizable()
    }
}
