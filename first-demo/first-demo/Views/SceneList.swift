//
//  SceneList.swift
//  first-demo
//
//  Created by kingcos on 2019/10/26.
//  Copyright © 2019 kingcos. All rights reserved.
//

import SwiftUI

struct SceneList: View {
    var body: some View {
//        List(sceneData, id: \.id) { scene in
//            SceneRow(scene: scene)
//        }
        
        NavigationView {
            List(sceneData) { scene in
                NavigationLink(destination: SceneDetail(scene: scene)) {
                    SceneRow(scene: scene)
                }
            }
            .navigationBarTitle(Text("景点"))
        }
    }
}

struct SceneList_Previews: PreviewProvider {
    static var previews: some View {
//        SceneList().previewDevice(PreviewDevice(rawValue: "iPhone SE"))
        // 设置预览设备
        ForEach(["iPhone SE", "iPhone XR", "iPhone 11 Pro Max"], id: \.self) { deviceName in
            SceneList().previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
