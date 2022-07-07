//
//  TCADemoApp.swift
//  TCADemo
//
//  Created by 买明 on 2022/7/6.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCADemoApp: App {
    var body: some Scene {
        WindowGroup {
//            ContentView(store: Store(initialState: Counter(),
//                                     reducer: counterReducer,
//                                     environment: CounterEnvironment()))
            
                MultiBindingsView(store: Store(
                    initialState: MyState(),
                    reducer: myReducer,
                    environment: MyEnvironment())
                )
        }
    }
}
