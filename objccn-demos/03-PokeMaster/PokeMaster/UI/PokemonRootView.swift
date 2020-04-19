//
//  PokemonRootView.swift
//  PokeMaster
//
//  Created by kingcos on 2020/3/19.
//  Copyright © 2020 OneV's Den. All rights reserved.
//

import SwiftUI

struct PokemonRootView: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        NavigationView {
            if store.appState.pokemonList.pokemons == nil {
                if store.appState.settings.loadError == nil {
                    Text("Loading...")
                        .onAppear {
                            // 显示时执行
                            self.store.dispatch(.loadPokemons)
                    }
                } else {
                    Button(action: {
                        self.store.dispatch(.loadPokemons)
                    }) {
                        Image(systemName: "arrow.clockwise")
                            .foregroundColor(Color.gray)
                        Text("Retry")
                            .foregroundColor(Color.gray)
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 2)
                    )
                }
            } else {
                PokemonList().navigationBarTitle("宝可梦列表")
            }
        }
    }
}

struct PokemonRootView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonRootView()
    }
}
