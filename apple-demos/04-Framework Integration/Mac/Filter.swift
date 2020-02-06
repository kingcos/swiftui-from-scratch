//
//  Filter.swift
//  Mac
//
//  Created by kingcos on 2020/2/6.
//  Copyright © 2020 kingcos. All rights reserved.
//

import SwiftUI

struct Filter: View {
    @EnvironmentObject private var userData: UserData
    @Binding var filter: FilterType
    
    var body: some View {
        HStack {
            Picker(selection: $filter, label: EmptyView()) {
                ForEach(FilterType.allCases) { choice in
                    Text(choice.name).tag(choice)
                }
            }

            Spacer()
            
            Toggle(isOn: $userData.showFavoritesOnly) {
                Text("Favorites only")
            }
        }
    }
}

struct Filter_Previews: PreviewProvider {
    static var previews: some View {
        Filter(filter: .constant(.all))
            .environmentObject(UserData())
    }
}

struct FilterType: CaseIterable, Hashable, Identifiable  {
    var name: String
    var category: Scene.Category?
    
    init(_ category: Scene.Category) {
        self.name = category.rawValue
        self.category = category
    }
    
    init(name: String) {
        self.name = name
        self.category = nil
    }
    
    // 默认的「全部」选项
    static var all = FilterType(name: "全部")
    
    static var allCases: [FilterType] {
        return [.all] + Scene.Category.allCases.map(FilterType.init)
    }
    
    var id: FilterType {
        return self
    }
}
