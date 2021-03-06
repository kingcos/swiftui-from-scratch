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
//    var subs = Set<AnyCancellable>()
    // 也可使用类似 RxSwift 中的 DisposeBag
    var disposeBag = DisposeBag()
    
    init() {
        setupObservers()
    }
    
    func setupObservers() {
        appState.settings.checker.isEmailValid.sink { isValid in
            self.dispatch(.emailValid(valid: isValid))
        }
        .add(to: disposeBag)
//        .store(in: &subs)
        
        appState.settings.checker.isPasswordValid.sink { isValid in
            self.dispatch(.passwordValid(valid: isValid))
        }
        .add(to: disposeBag)
        
        appState.settings.checker.isRegisterValid.sink { isValid in
            self.dispatch(.registerValid(valid: isValid))
        }
        .add(to: disposeBag)
    }
    
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
            
        case .register(let email, let password):
            guard !appState.settings.registerRequesting else {
                break
            }
            appState.settings.registerRequesting = true
            appCommand = RegisterCommand(email: email, password: password)
            
        case .accountBehaviorDone(let result):
            // 登录请求结束
            appState.settings.loginRequesting = false
            appState.settings.registerRequesting = false
            
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
            
        case .emailValid(let valid):
            appState.settings.isEmailValid = valid
            
        case .passwordValid(let valid):
            appState.settings.isPasswordValid = valid
            
        case .registerValid(let valid):
            appState.settings.isRegisterValid = valid
            
        case .loadPokemons:
            if appState.pokemonList.loadingPokemons {
                break
            }
            
            appState.pokemonList.loadingPokemons = true
            appCommand = LoadPokemonsCommand()
            
        case .loadPokemonsDone(let result):
            appState.pokemonList.loadingPokemons = false
            
            switch result {
            case .success(let models):
                // 将一个键值对序列转换为字典，其中键值对的首个元素会被作为 key。[id : Pokemon]
                appState.pokemonList.pokemons = Dictionary(uniqueKeysWithValues: models.map { ($0.id, $0) })
            case .failure(let error):
                appState.settings.loadError = error
            }
            
        case .clearCache:
            appState.pokemonList.pokemons = nil
            appState.pokemonList.abilities = nil
            
        case .toggleListSelection(let index):
            if appState.pokemonList.selectionState.expandingIndex == index {
                appState.pokemonList.selectionState.expandingIndex = nil
                appState.pokemonList.selectionState.panelPresented = false
                appState.pokemonList.selectionState.radarProgress = 0
            } else {
                appState.pokemonList.selectionState.expandingIndex = index
                appState.pokemonList.selectionState.panelIndex = index
                appState.pokemonList.selectionState.radarShouldAnimate =
                    appState.pokemonList.selectionState.radarProgress == 1 ? false : true
            }
            
        case .togglePanelPresenting(let presenting):
            appState.pokemonList.selectionState.panelPresented = presenting
            appState.pokemonList.selectionState.radarProgress = presenting ? 1 : 0
            
        case .loadAbilities(let pokemon):
            if appState.pokemonList.loadingAbilities {
                break
            }
        
            appState.pokemonList.loadingAbilities = true
            appCommand = LoadAbilitiesCommand(pokemon: pokemon)
        case .loadAbilitiesDone(let result):
            appState.pokemonList.loadingAbilities = false
            
            switch result {
            case .success(let models):
//                appState.pokemonList.abilities = models.flatMap { [$0.id: $0] }
                var abs = appState.pokemonList.abilities ?? [:]
                for ab in models {
                    abs[ab.id] = ab
                }
                appState.pokemonList.abilities = abs
            case .failure(let error):
                print(error)
            }
            
        case .closeSafariView:
            appState.pokemonList.isSFViewActive = false
            
        case .openSafariView(let url):
            appState.pokemonList.openURL = url
            appState.pokemonList.isSFViewActive = true
            
        case .addToFavorite:
            appState.pokemonList.isShowLoginAlert = appState.settings.loginUser == nil
            
        case .switchToSelection(let selection):
            appState.mainTab.selection = selection
        }
        
        return (appState, appCommand)
    }
}
