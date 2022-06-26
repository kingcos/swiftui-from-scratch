//
//  Scene.swift
//  01-SwiftUI Essentials
//
//  Created by kingcos on 2020/2/4.
//  Copyright © 2020 kingcos. All rights reserved.
//

import SwiftUI
import CoreLocation

struct Scene: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var state: String
    var isFavorite: Bool
    var isFeatured: Bool
    var description: String
    
    private var coordinates: Coordinates
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
    }
    struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longitude: Double
    }
    
    var category: Category
    enum Category: String, CaseIterable, Codable {
        case museum     = "博物馆"
        case nature     = "自然"
        case university = "大学"
        case history    = "历史"
    }
    
    private var imageName: String
    var image: Image {
        Image(imageName)
    }
    var featureImage: Image? {
        isFeatured ? Image(imageName + "_feature") : nil
    }
}

//extension Scene {
//    var image: Image {
//        ImageStore.shared.image(name: imageName)
//    }
//}
