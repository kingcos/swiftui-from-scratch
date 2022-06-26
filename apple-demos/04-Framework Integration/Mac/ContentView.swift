//
//  ContentView.swift
//  Mac
//
//  Created by kingcos on 2020/2/6.
//  Copyright © 2020 kingcos. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedScene: Scene?

    var body: some View {
        SceneList()
            .frame(minWidth: 700, minHeight: 300)
        
//        NavigationView {
//            NavigationMaster(selectedScene: $selectedScene)
//
//            if selectedScene != nil {
//                NavigationDetail(scene: selectedScene!)
//            }
//        }
//        .frame(minWidth: 700, minHeight: 300)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserData())
    }
}
