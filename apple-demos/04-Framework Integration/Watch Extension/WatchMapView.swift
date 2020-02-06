//
//  WatchMapView.swift
//  Watch Extension
//
//  Created by kingcos on 2020/2/6.
//  Copyright © 2020 kingcos. All rights reserved.
//

import SwiftUI

struct WatchMapView: WKInterfaceObjectRepresentable {
    var scene: Scene
    
    // 创建由 WatchMapView 展示的 WatchKit 地图
    func makeWKInterfaceObject(context: WKInterfaceObjectRepresentableContext<WatchMapView>) -> WKInterfaceMap {
        return WKInterfaceMap()
    }
    
    func updateWKInterfaceObject(_ map: WKInterfaceMap, context: WKInterfaceObjectRepresentableContext<WatchMapView>) {
        let span = MKCoordinateSpan(latitudeDelta: 0.02,
            longitudeDelta: 0.02)
        
        let region = MKCoordinateRegion(
            center: scene.locationCoordinate,
            span: span)
        
        map.setRegion(region)
    }
}

struct WatchMapView_Previews: PreviewProvider {
    static var previews: some View {
        WatchMapView(scene: UserData().scenes[0])
    }
}
