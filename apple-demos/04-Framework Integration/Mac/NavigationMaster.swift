//
//  NavigationMaster.swift
//  Mac
//
//  Created by kingcos on 2020/2/6.
//  Copyright © 2020 kingcos. All rights reserved.
//

import SwiftUI

struct NavigationMaster: View {
    @Binding var selectedScene: Scene?
    @State private var filter: FilterType = .all
    
    var body: some View {
        VStack {
          Filter(filter: $filter)
              .controlSize(.small)
              .padding([.top, .leading], 8)
              .padding(.trailing, 4)
            
            SceneList(
                selectedScene: $selectedScene,
                filter: $filter
            )
            .listStyle(SidebarListStyle())
        }
        .frame(minWidth: 225, maxWidth: 300)
    }
}

struct NavigationMaster_Previews: PreviewProvider {
    static var previews: some View {
        NavigationMaster(selectedScene: .constant(sceneData[1]))
            .environmentObject(UserData())
    }
}
