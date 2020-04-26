//
//  SceneDelegate.swift
//  PokeMaster
//
//  Created by Wang Wei on 2019/08/28.
//  Copyright © 2019 OneV's Den. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    private func showMainTab(scene: UIScene,
                             with store: Store) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: MainTab().environmentObject(store))
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
    private func createStore(_ URLContexts: Set<UIOpenURLContext>) -> Store {
        let store = Store()
        
        guard let url = URLContexts.first?.url,
            let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return store }
        
        switch (components.scheme, components.host) {
        // pokemaster://showPanel?id={id}
        case ("pokemaster", "showPanel"):
            guard let idQuery = (components.queryItems?.first { $0.name == "id" }),
                  let idString = idQuery.value,
                  let id = Int(idString) else { break }
            
            store.appState.pokemonList.selectionState = .init(expandingIndex: id,
                                                              panelIndex: id,
                                                              panelPresented: true)
        // pokemaster://userRegister?email=admin@example.com
        case ("pokemaster", "userRegister"):
            guard let emailQuery = (components.queryItems?.first { $0.name == "email" }),
                  let email = emailQuery.value else { break }
            
            store.appState.mainTab.selection = .settings
            store.appState.settings.checker.accountBehavior = .register
            store.appState.settings.checker.email = email
        default:
            break
        }
        
        return store
    }

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        let store = createStore(connectionOptions.urlContexts)
        showMainTab(scene: scene, with: store)
        
//        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
//        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
//        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
//
//        // Create the SwiftUI view that provides the window contents.
//        // 内部子控件谁需要 environmentObject 谁声明即可自动注入
//        let contentView = MainTab().environmentObject(Store())
//
//        // Use a UIHostingController as window root view controller.
//        if let windowScene = scene as? UIWindowScene {
//            let window = UIWindow(windowScene: windowScene)
//            window.rootViewController = UIHostingController(rootView: contentView)
//            self.window = window
//            window.makeKeyAndVisible()
//        }
    }
    
    func scene(_ scene: UIScene,
               openURLContexts URLContexts: Set<UIOpenURLContext>) {
        let store = createStore(URLContexts)
        showMainTab(scene: scene, with: store)
    }


}

