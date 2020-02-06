//
//  NavigationDetail.swift
//  Mac
//
//  Created by kingcos on 2020/2/6.
//  Copyright © 2020 kingcos. All rights reserved.
//

import SwiftUI
import MapKit

struct NavigationDetail: View {
    @EnvironmentObject var userData: UserData
    
    var scene: Scene
    
    var sceneIndex: Int {
        userData.scenes.firstIndex(where: { $0.id == scene.id })!
    }
    
    var body: some View {
        ScrollView {
            MapView(coordinate: scene.locationCoordinate)
                .frame(height: 250)
                .overlay(
                    GeometryReader { proxy in
                        Button("Open in Maps") {
                            let destination = MKMapItem(placemark: MKPlacemark(coordinate: self.scene.locationCoordinate))
                            destination.name = self.scene.name
                            destination.openInMaps()
                        }
                        .frame(width: proxy.size.width, height: proxy.size.height, alignment: .bottomTrailing)
                        .offset(x: -10, y: -10)
                    }
            )
            
            VStack(alignment: .leading, spacing: 12) {
                HStack(alignment: .center, spacing: 24) {
                    CircleImage(image: scene.image.resizable(), shadowRadius: 4)
                        .frame(width: 160, height: 160)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text(scene.name).font(.title)
                            
                            Button(action: {
                                self.userData.scenes[self.sceneIndex]
                                    .isFavorite.toggle()
                            }) {
                                if userData.scenes[self.sceneIndex].isFavorite {
                                    Image("star-filled")
                                        .resizable()
                                        .renderingMode(.template)
                                        .foregroundColor(.yellow)
                                        .accessibility(label: Text("Remove from favorites"))
                                } else {
                                    Image("star-empty")
                                        .resizable()
                                        .renderingMode(.template)
                                        .foregroundColor(.gray)
                                        .accessibility(label: Text("Add to favorites"))
                                }
                            }
                            .frame(width: 20, height: 20)
                            .buttonStyle(PlainButtonStyle())
                        }
                        
                        Text(scene.category.rawValue)
                        Text(scene.state)
                    }
                    .font(.caption)
                }
                
                Divider()
                
                Text("About \(scene.name)")
                    .font(.headline)
                
                Text(scene.description)
                    .lineLimit(nil)
            }
            .padding()
            .frame(maxWidth: 700)
            .offset(x: 0, y: -50)
        }
    }
}

struct NavigationDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationDetail(scene: sceneData[0])
            .environmentObject(UserData())
    }
}
