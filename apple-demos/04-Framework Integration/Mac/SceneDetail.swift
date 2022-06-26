//
//  SceneDetail.swift
//  Mac
//
//  Created by kingcos on 2022/6/26.
//  Copyright © 2022 kingcos. All rights reserved.
//

import SwiftUI
import MapKit

struct SceneDetail: View {
    @EnvironmentObject var userData: UserData
    var scene: Scene

    var sceneIndex: Int {
        userData.scenes.firstIndex(where: { $0.id == scene.id })!
    }
    
    var body: some View {
        ScrollView {
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                MapView(coordinate: scene.locationCoordinate)
                    .ignoresSafeArea(edges: .top)
                    .frame(height: 300)

                Button("Open in Maps") {
                    let destination = MKMapItem(placemark: MKPlacemark(coordinate: scene.locationCoordinate))
                    destination.name = scene.name
                    destination.openInMaps()
                }
                .padding()
            }
            
            VStack(alignment: .leading, spacing: 20) {
                HStack(spacing: 24) {
                    CircleImage(image: scene.image.resizable())
                        .frame(width: 160, height: 160)
                    
                    HStack {
                        Text(scene.name)
                            .font(.title)
                        FavoriteButton(isSet: $userData.scenes[sceneIndex].isFavorite)
                            .buttonStyle(.plain)
                    }

                    VStack(alignment: .leading) {
                        Text(scene.category.rawValue)
                        Text(scene.state)
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }

                Divider()

                Text("About \(scene.name)")
                    .font(.title2)
                Text(scene.description)
            }
            .padding()
            .frame(maxWidth: 700)
            .offset(y: -50)
        }
        .navigationTitle(scene.name)
    }
}

struct SceneDetail_Previews: PreviewProvider {
    static let userData = UserData()
    
    static var previews: some View {
        SceneDetail(scene: userData.scenes[0])
            .environmentObject(userData)
            .frame(width: 850, height: 700)
    }
}
