//
//  Home.swift
//  03-App Design and Layout
//
//  Created by kingcos on 2020/2/5.
//  Copyright © 2020 kingcos. All rights reserved.
//

import SwiftUI

struct CategoryHome: View {
    var categories: [String: [Scene]] {
        Dictionary(
            grouping: sceneData,
            by: { $0.category.rawValue }
        )
    }
    
    var featured: [Scene] {
        sceneData.filter { $0.isFavorite }
    }
    
    @State var showingProfile = false
    
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
                FeaturedScenes(scenes: featured)
                    .scaledToFill()
                    .frame(height: 200)
                    .clipped()
                    .listRowInsets(EdgeInsets())
                
                ForEach(categories.keys.sorted(), id: \.self) { key in
                    CategoryRow(categoryName: key, items: self.categories[key]!)
                }
                .listRowInsets(EdgeInsets())
                
                NavigationLink(destination: SceneList()) {
                    Text("See All")
                }
            }
            .navigationBarTitle(Text("Featured"))
            .navigationBarItems(trailing: profileButton)
            .sheet(isPresented: $showingProfile) {
                Text("User Profile")
            }
        }
    }
}

struct CategoryHome_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHome()
    }
}

struct FeaturedScenes: View {
    var scenes: [Scene]
    
    var body: some View {
        scenes[0].image.resizable()
    }
}
