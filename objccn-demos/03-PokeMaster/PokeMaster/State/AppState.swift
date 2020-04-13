//
//  AppState.swift
//  PokeMaster
//
//  Created by kingcos on 2020/4/13.
//  Copyright © 2020 OneV's Den. All rights reserved.
//

import Foundation

struct AppState {
    // 局部 Settings 类型
    var settings = Settings()
}

extension AppState {
    struct Settings {
        enum Sorting: CaseIterable {
            case id, name, color, favorite
        }
        
        var showEnglishName = true
        var sorting = Sorting.id
        var showFavoriteOnly = false
    }
}
