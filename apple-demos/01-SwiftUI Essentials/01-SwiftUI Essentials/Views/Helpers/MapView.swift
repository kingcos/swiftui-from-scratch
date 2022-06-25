//
//  MapView.swift
//  01-SwiftUI Essentials
//
//  Created by kingcos on 2020/2/4.
//  Copyright © 2020 kingcos. All rights reserved.
//

import SwiftUI
import MapKit

// 将 UIKit 控件嵌入 SwiftUI
//struct MapView: UIViewRepresentable {
//    var coordinate: CLLocationCoordinate2D
//
//    func makeUIView(context: Context) -> MKMapView {
//        MKMapView(frame: .zero)
//    }
//
//    func updateUIView(_ view: MKMapView, context: Context) {
//        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
//        let region = MKCoordinateRegion(center: coordinate, span: span)
//        view.setRegion(region, animated: true)
//    }
//}

@available(iOS 14.0, *)
struct MapView: View {
    var coordinate: CLLocationCoordinate2D
    @State private var region = MKCoordinateRegion()
    
    var body: some View {
        Map(coordinateRegion: $region)
            .onAppear {
                // 展示时设置坐标
                setRegion(coordinate)
            }
    }
    
    private func setRegion(_ coordinate: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(coordinate: CLLocationCoordinate2D(latitude: 39.943_923,
                                                   longitude: 116.474_718))
    }
}
