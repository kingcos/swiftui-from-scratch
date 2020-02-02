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
        // 默认选择 tab，但会导致其他 tab 不渲染，Bug？
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
            
            Settings()
                .tabItem({
                    Image("IconSettings")
                        .renderingMode(.template)
                    Text("Settings")
                })
                .tag(3)
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TabBar()
            
            TabBar()
                .environment(\.colorScheme, .dark)
                .environment(\.sizeCategory, .extraExtraLarge)
        }
    }
}
