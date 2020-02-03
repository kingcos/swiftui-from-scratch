//
//  SceneList.swift
//  01-SwiftUI Essentials
//
//  Created by kingcos on 2020/2/4.
//  Copyright © 2020 kingcos. All rights reserved.
//

import SwiftUI

struct SceneList: View {
    var body: some View {
        NavigationView {
            List(sceneData) { scene in
                NavigationLink(destination: SceneDetail(scene: scene)) {
                    SceneRow(scene: scene)
                }
            }
            .navigationBarTitle(Text("Scenes"))
        }
    }
}

struct SceneList_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SceneList()
                .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
            
            ForEach(["iPhone SE", "iPhone XS Max"], id: \.self) { deviceName in
                SceneList()
                    .previewDevice(PreviewDevice(rawValue: deviceName))
                    .previewDisplayName(deviceName)
            }
        }
    }
}
