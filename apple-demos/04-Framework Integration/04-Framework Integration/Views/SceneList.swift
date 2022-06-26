//
//  SceneList.swift
//  01-SwiftUI Essentials
//
//  Created by kingcos on 2020/2/4.
//  Copyright © 2020 kingcos. All rights reserved.
//

import SwiftUI

struct SceneList: View {
    @EnvironmentObject var userData: UserData
    @State var showFavoritesOnly = false
    @State private var filter = FilterCategory.all
//    @State private var selectedScene: Scene?
    
    enum FilterCategory: String, CaseIterable, Identifiable {
        case all = "All"
        case museum     = "博物馆"
        case nature     = "自然"
        case university = "大学"
        case history    = "历史"

        var id: FilterCategory { self }
    }
    
    var filteredScenes: [Scene] {
        userData.scenes.filter { scene in
            (!showFavoritesOnly || scene.isFavorite)
            && (filter == .all || filter.rawValue == scene.category.rawValue)
        }
    }
    
    
    var title: String {
        let title = filter == .all ? "Scene" : filter.rawValue
        return showFavoritesOnly ? "Favorite \(title)" : title
    }
    
//    var index: Int? {
//        userData.scenes.firstIndex(where: { $0.id == selectedScene?.id })
//    }
    
    var body: some View {
        NavigationView {
            List {
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Favorites only")
                }
                
//                    List(selection: $selectedScene) {
                    ForEach(filteredScenes) { scene in
                        NavigationLink {
                            SceneDetail(scene: scene)
                                .environmentObject(userData)
                        } label: {
                            SceneRow(scene: scene)
                        }
//                        .tag(scene)
                    }
//                }
            }
            
//            List {
//                Toggle(isOn: $userData.showFavoritesOnly) {
//                    Text("Favorites only")
//                }
//
//                ForEach(userData.scenes) { scene in
//                    if !self.userData.showFavoritesOnly || scene.isFavorite {
//                        NavigationLink(destination: SceneDetail(scene: scene)) {
//                            SceneRow(scene: scene)
//                        }
//                    }
//                }
//            }
            .navigationTitle(title)
            .frame(minWidth: 300)
            .toolbar {
                ToolbarItem {
                    Menu {
                        Picker("Category", selection: $filter) {
                            ForEach(FilterCategory.allCases) { category in
                                Text(category.rawValue).tag(category)
                            }
                        }
                        .pickerStyle(.inline)
                        
                        Toggle(isOn: $showFavoritesOnly) {
                            Label("Favorites only", systemImage: "star.fill")
                        }
                    } label: {
                        Label("Filter", systemImage: "slider.horizontal.3")
                    }
                }
            }
            
            Text("Select a scene")
        }
//        .focusedValue(\.selectedScene, $userData.scenes[index ?? 0])
    }
}

//struct SceneList<DetailView: View>: View {
//    @EnvironmentObject var userData: UserData
//    // @State var showFavoritesOnly = true
//
//    // 让外部决定详情页的类型
//    let detailViewProducer: (Scene) -> DetailView
//
//    var body: some View {
////        NavigationView {
//            List {
//                Toggle(isOn: $userData.showFavoritesOnly) {
//                    Text("Favorites only")
//                }
//
//                ForEach(userData.scenes) { scene in
//                    if !self.userData.showFavoritesOnly || scene.isFavorite {
//                        NavigationLink(
////                        destination: SceneDetail(scene: scene)) {
//                            destination: self.detailViewProducer(scene).environmentObject(self.userData)) {
//                            SceneRow(scene: scene)
//                        }
//                    }
//                }
//            }
//            .navigationBarTitle(Text("Scenes"))
////        }
//    }
//}
//
//
//#if os(watchOS)
//typealias PreviewDetailView = WatchSceneDetail
//#else
//typealias PreviewDetailView = SceneDetail
//#endif
//
//struct SceneList_Previews: PreviewProvider {
//    static var previews: some View {
//        SceneList { PreviewDetailView(scene: $0) }
//            .environmentObject(UserData())
//    }
//}
//
struct SceneList_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SceneList()
                .environmentObject(UserData())
                .previewDevice(PreviewDevice(rawValue: "iPhone SE"))

            ForEach(["iPhone SE", "iPhone XS Max"], id: \.self) { deviceName in
                SceneList()
                    .environmentObject(UserData())
                    .previewDevice(PreviewDevice(rawValue: deviceName))
                    .previewDisplayName(deviceName)
            }
        }
    }
}
