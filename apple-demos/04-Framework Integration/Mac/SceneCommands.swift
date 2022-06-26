//
//  SceneCommands.swift
//  04-Framework Integration
//
//  Created by kingcos on 2022/6/26.
//  Copyright © 2022 kingcos. All rights reserved.
//

import Foundation
import SwiftUI

struct SceneCommands: Commands {
    @FocusedBinding(\.selectedScene) var selectedScene
    
    var body: some Commands {
        SidebarCommands()
        
        CommandMenu("Scene") {
            Button("\(selectedScene?.isFavorite == true ? "Remove" : "Mark") as Favorite") {
                selectedScene?.isFavorite.toggle()
            }
            .keyboardShortcut("f", modifiers: [.shift, .option])
            .disabled(selectedScene == nil)
        }
    }
}

private struct SelectedSceneKey: FocusedValueKey {
    typealias Value = Binding<Scene>
}

extension FocusedValues {
    var selectedScene: Binding<Scene>? {
        get { self[SelectedSceneKey.self] }
        set { self[SelectedSceneKey.self] = newValue }
    }
}
