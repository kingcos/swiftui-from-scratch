//
//  MainTab.swift
//  PokeMaster
//
//  Created by kingcos on 2020/4/12.
//  Copyright © 2020 OneV's Den. All rights reserved.
//

import SwiftUI

struct MainTab: View {
    
    @EnvironmentObject var store: Store
    
    private var pokemonList: AppState.PokemonList {
        store.appState.pokemonList
    }
    private var pokemonListBinding: Binding<AppState.PokemonList> {
        $store.appState.pokemonList
    }

    private var selectedPanelIndex: Int? {
        pokemonList.selectionState.panelIndex
    }
    
    var body: some View {
//        TabView(selection: $store.appState.mainTab.selection) {
//            PokemonRootView().tabItem {
//                Image(systemName: "list.bullet.below.rectangle")
//                Text("列表")
//            }
//            .tag(AppState.MainTab.Index.list)
//
//
//            SettingRootView().tabItem {
//                Image(systemName: "gear")
//                Text("设置")
//            }
//            .tag(AppState.MainTab.Index.settings)
//        }
        
        TabView {
            PokemonRootView().tabItem {
                // tabItem 只接受 Image 和 Text
                Image(systemName: "list.bullet.below.rectangle")
                Text("列表")
            }

            SettingRootView().tabItem {
                Image(systemName: "gear")
                Text("设置")
            }
        }
//        .edgesIgnoringSafeArea(.top)
//        .overlay(panel) // 依赖 Store
        .overlaySheet(isPresented: pokemonListBinding.selectionState.panelPresented) {
            if self.selectedPanelIndex != nil
            && self.pokemonList.pokemons != nil {
                PokemonInfoPanel(model: self.pokemonList.pokemons![self.selectedPanelIndex!]!)
            }
        }
    }
    
    var panel: some View {
        // 这里需要返回 some View，通过 Group 把不同类型的 View 包装到 Group View 中，或使用 AnyView 抹除具体类型
        Group {
            if pokemonList.selectionState.panelPresented {
                // if let 此处不可用
                if selectedPanelIndex != nil && pokemonList.pokemons != nil {
                    PokemonInfoPanelOverlay(model: pokemonList.pokemons![selectedPanelIndex!]!)
                } else {
                    EmptyView()
                }
            } else {
                EmptyView()
            }
        }
    }
}

struct MainTab_Previews: PreviewProvider {
    static var previews: some View {
        MainTab()
    }
}
