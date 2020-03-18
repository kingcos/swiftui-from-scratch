//
//  PokemonList.swift
//  PokeMaster
//
//  Created by kingcos on 2020/3/19.
//  Copyright © 2020 OneV's Den. All rights reserved.
//

import SwiftUI

struct PokemonList: View {
    @State var expandingIndex: Int?
    
    var body: some View {
//        // List 的数组元素必须遵守 Identifiable 协议；List 暂时无法去掉分割线
//        List(PokemonViewModel.all) { pokemon in
//            PokemonInfoRow(model: pokemon, expanded: false)
//        }
        ScrollView { // 没有重用机制，少量可用
            ForEach(PokemonViewModel.all) { pokemon in
                PokemonInfoRow(model: pokemon,
                    expanded: self.expandingIndex == pokemon.id)
                    .onTapGesture {
                        if self.expandingIndex == pokemon.id {
                            // 取消选中
                            self.expandingIndex = nil
                        } else {
                            // 选中
                            self.expandingIndex = pokemon.id
                        }
                }
            }
        }
    }
}

struct PokemonList_Previews: PreviewProvider {
    static var previews: some View {
        PokemonList()
    }
}
