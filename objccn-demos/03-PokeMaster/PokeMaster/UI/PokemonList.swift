//
//  PokemonList.swift
//  PokeMaster
//
//  Created by kingcos on 2020/3/19.
//  Copyright © 2020 OneV's Den. All rights reserved.
//

import SwiftUI

struct PokemonList: View {
//    @State var expandingIndex: Int?
//    @State var searchText: String = ""
    var bindingPokemonList: Binding<AppState.PokemonList> {
        $store.appState.pokemonList
    }
    
    var pokemonList: AppState.PokemonList {
        store.appState.pokemonList
    }
    
    @EnvironmentObject var store: Store
    
    var body: some View {
//        // List 的数组元素必须遵守 Identifiable 协议；List 暂时无法去掉分割线
//        List(PokemonViewModel.all) { pokemon in
//            PokemonInfoRow(model: pokemon, expanded: false)
//        }
        ScrollView { // 没有重用机制，少量可用
//            SearchBar()
            TextField("搜索", text: bindingPokemonList.searchText)
                .frame(height: 40)
                .padding(.horizontal, 25)
//            ForEach(PokemonViewModel.all) { pokemon in
            ForEach(store.appState.pokemonList.allPokemonsByID) { pokemon in
                PokemonInfoRow(model: pokemon,
                               expanded: self.pokemonList.expandingIndex == pokemon.id)
                    .onTapGesture {
                        self.store.dispatch(.toggleListSelection(index: pokemon.id))
                        self.store.dispatch(.loadAbilities(pokemon: pokemon.pokemon))
                        
                        /*
                        if self.pokemonList.expandingIndex == pokemon.id {
                            // 取消选中
//                            pokemonList.expandingIndex = nil
                            self.store.dispatch(.toggleListSelection(index: nil))
                        } else {
                            // 选中
//                            pokemonList.expandingIndex = pokemon.id
                            self.store.dispatch(.toggleListSelection(index: pokemon.id))
                        }
                        */
                }
            }
        }
//        .overlay( // 在当前 View 上方添加另外的 View，类似 ZStack，但会尊重下方的 View 的布局
//            VStack {
//                Spacer()
//                PokemonInfoPanel(model: .sample(id: 1))
//            }
//            .edgesIgnoringSafeArea(.bottom)
//        )
    }
}

struct PokemonList_Previews: PreviewProvider {
    static var previews: some View {
        PokemonList()
    }
}
