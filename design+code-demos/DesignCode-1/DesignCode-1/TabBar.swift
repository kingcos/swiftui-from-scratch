//
//  TabBar.swift
//  DesignCode-1
//
//  Created by kingcos on 2020/2/3.
//  Copyright © 2020 kingcos. All rights reserved.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
//        TabView(selection: .constant(2)) {
        TabView {
            Home()
                .tabItem({
                    Image("IconHome")
                        .renderingMode(.template)
                    Text("Home")
                })
                .tag(1)
            
            ContentView()
                .tabItem({
                    Image("IconCards")
                        .renderingMode(.template)
                    Text("Certificates")
                })
                .tag(2)
            
            UpdateList()
                .tabItem({
                    Image("IconSettings")
                        .renderingMode(.template)
                    Text("Updates")
                })
                .tag(3)
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
