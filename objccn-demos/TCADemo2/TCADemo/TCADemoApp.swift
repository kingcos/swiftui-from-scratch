//
//  TCADemoApp.swift
//  TCADemo
//
//  Created by kingcos on 2022/7/6.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCADemoApp: App {
    var body: some Scene {
        WindowGroup {
//            MultiBindingsView(store: Store(
//                                initialState: MyState(),
//                                reducer: myReducer,
//                                environment: MyEnvironment())
//                            )
            
//            ContentView(store: Store(initialState: Counter(),
//                                     reducer: counterReducer,
////                                     environment: CounterEnvironment(generateRandom: { Int.random(in: $0) })
//                                     environment: .live
//                                    ))
            
//            GameView(store: Store(initialState: GameState(), reducer: gameReducer, environment: GameEnvironment()))
            GameView(store: Store(initialState: GameState(), reducer: gameReducer, environment: .live))
        }
    }
}
