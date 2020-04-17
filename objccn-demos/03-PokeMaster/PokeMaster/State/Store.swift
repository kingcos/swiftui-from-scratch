//
//  Store.swift
//  PokeMaster
//
//  Created by kingcos on 2020/4/13.
//  Copyright © 2020 OneV's Den. All rights reserved.
//

import Combine

class Store: ObservableObject {
    @Published var appState = AppState()
    
    func dispatch(_ action: AppAction) {
        #if DEBUG
        print("[ACTION]: \(action)")
        #endif
        
        let result = Store.reduce(state: appState, action: action)
        appState = result
    }
    
    // 职责在于输入 State & Action 输出新 State
    // Old State + Action -> Reducer -> New State -> View -> Action
    static func reduce(
        state: AppState,
        action: AppAction
    ) -> AppState {
        var appState = state
        
        switch action {
            //处理每一种 View 引发的 Action
            
        case .login(let email, let password):
            // login Action -> State 更新
            if password == "password" {
                let user = User(email: email, favoritePokemonIDs: [])
                appState.settings.loginUser = user
            }
        }
        
        return appState
    }
}
