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
    
    // 存储订阅，防止订阅释放
    var subs = Set<AnyCancellable>()
    
    func dispatch(_ action: AppAction) {
        #if DEBUG
        print("[ACTION]: \(action)")
        #endif
        
        let result = Store.reduce(state: appState, action: action)
        appState = result.0
        
        if let command = result.1 {
            // 有 command 时取出并执行
            
            #if DEBUG
            print("[COMMAND]: \(command)")
            #endif
            
            command.execute(in: self)
        }
    }
    
    // 职责在于输入 State & Action 输出新 State
    // Old State + Action -> Reducer -> New State -> View -> Action
    static func reduce(
        state: AppState,
        action: AppAction
    ) -> (AppState, AppCommand?) {
        var appState = state
        var appCommand: AppCommand?
        
        switch action {
        //处理每一种 View 引发的 Action
            
        case .login(let email, let password):
            // login Action -> State 更新
//            if password == "password" {
//                let user = User(email: email, favoritePokemonIDs: [])
//                appState.settings.loginUser = user
//            }
            
            // 防止重复进入请求中
            guard !appState.settings.loginRequesting else {
                break
            }
            appState.settings.loginRequesting = true
            // 副作用交由 Command 处理
            appCommand = LoginAppCommand(email: email, password: password)
            
        case .accountBehaviorDone(let result):
            // 登录请求结束
            appState.settings.loginRequesting = false
            
            switch result {
            case .success(let user):
                appState.settings.loginUser = user
//                appCommand = WriteUserAppCommand(user: user)
                
            case .failure(let error):
                print("Error: \(error)")
                appState.settings.loginError = error
            }
            
        case .logout:
            appState.settings.loginUser = nil
        }
        
        return (appState, appCommand)
    }
}
