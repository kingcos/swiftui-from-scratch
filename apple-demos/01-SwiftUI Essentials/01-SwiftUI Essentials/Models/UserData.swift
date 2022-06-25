//
//  UserData.swift
//  01-SwiftUI Essentials
//
//  Created by kingcos on 2020/2/4.
//  Copyright © 2020 kingcos. All rights reserved.
//

import Foundation
import Combine

//final class UserData: ObservableObject {
//    @Published var showFavoritesOnly = false
//    @Published var scenes = sceneData
//}

// 从 Combine 框架中声明符合 ObservableObject 协议的新模型类型。
// SwiftUI 将订阅 ObservableObject，并在数据更改时更新任何需要刷新的视图。
final class UserData: ObservableObject {
    @Published var sceneData: [Scene] = load("sampleData.json")
}
