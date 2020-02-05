//
//  CategoryRow.swift
//  03-App Design and Layout
//
//  Created by kingcos on 2020/2/5.
//  Copyright © 2020 kingcos. All rights reserved.
//

import SwiftUI

struct CategoryRow: View {
    var categoryName: String
    var items: [Scene]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(self.categoryName)
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(self.items) { scene in
                        NavigationLink(destination: SceneDetail(scene: scene)) {
                            CategoryItem(scene: scene)
                        }
                    }
                }
            }
            .frame(height: 185)
        }
    }
}

struct CategoryRow_Previews: PreviewProvider {
    static var previews: some View {
        CategoryRow(
            categoryName: sceneData[0].category.rawValue,
            items: Array(sceneData.prefix(3))
        )
    }
}

struct CategoryItem: View {
    var scene: Scene
    
    var body: some View {
        VStack(alignment: .leading) {
            scene.image
                .renderingMode(.original)
                .resizable()
                .frame(width: 155, height: 155)
                .cornerRadius(5)
            Text(scene.name)
                .foregroundColor(.primary)
                .font(.caption)
        }
        .padding(.leading, 15)
    }
}
