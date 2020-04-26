//
//  PokemonInfoPanel.swift
//  PokeMaster
//
//  Created by kingcos on 2020/3/19.
//  Copyright © 2020 OneV's Den. All rights reserved.
//

import SwiftUI

struct PokemonInfoPanel: View {
    let model: PokemonViewModel
    
    @State var darkBlur = false
    @EnvironmentObject var store: Store
    @Environment(\.colorScheme) var colorScheme
    
    var abilities: [AbilityViewModel]? {
//        AbilityViewModel.sample(pokemonID: model.id)
        store.appState.pokemonList.abilityViewModels(for: model.pokemon)
    }
    
    var topIndicator: some View {
        RoundedRectangle(cornerRadius: 3)
            .frame(width: 40, height: 5)
            .opacity(0.2)
    }
    
    // 默认情况 Text 会显示全部文本，如果想要限制行数，可以设置 .lineLimit(2)
    var pokemonDescription: some View {
        Text(model.descriptionText)
            .font(.callout)
            .foregroundColor(
                colorScheme == .light ? Color(hex: 0x666666) : Color(hex: 0xAAAAAA)
            )
//            .foregroundColor(Color(hex: 0x666666))
            .fixedSize(horizontal: false, vertical: true) // 多行显示
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Button(action: {
                self.darkBlur.toggle()
            }) {
                Text("切换模糊效果")
            }
            topIndicator
            
            // 取消部分视图的动画
            Group {
                Header(model: model)
                pokemonDescription
            }
            .animation(nil)
            
            Divider()
            HStack(spacing: 20) {
                AbilityList(
                    model: model,
                    abilityModels: abilities
                )
                RadarView(values: model.pokemon.stats.map { $0.baseStat },
                          color: model.color,
                          max: 120,
                          progress: CGFloat(store.appState.pokemonList.selectionState.radarProgress),
                          shouldAnimate: store.appState.pokemonList.selectionState.radarShouldAnimate)
                .frame(width: 100, height: 100)
            }
        }
        .padding(.top, 12)
        .padding(.bottom, 30)
        .padding(.horizontal, 30)
//          .padding(
//            EdgeInsets(
//                top: 12,
//                leading: 30,
//                bottom: 30,
//                trailing: 30
//              )
//            )
            //        .background(Color.white)
            //        .background(BlurView(style: .systemMaterial))
            .blurBackground(style: darkBlur ? .systemMaterialDark : .systemMaterial)
            .cornerRadius(20)
            .fixedSize(horizontal: false, vertical: true)
        
    }
}

extension PokemonInfoPanel {
    struct Header: View {
        let model: PokemonViewModel
        
        var pokemonIcon: some View {
            Image("Pokemon-\(model.id)")
                .resizable()
                .frame(width: 68, height: 68)
        }
        
        var nameSpecies: some View {
            VStack(spacing: 10) {
                VStack {
                    Text(model.name)
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                        .foregroundColor(model.color)
                    Text(model.nameEN)
                        .font(.system(size: 13))
                        .fontWeight(.bold)
                        .foregroundColor(model.color)
                }
                Text(model.genus)
                    .font(.system(size: 13))
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
            }
        }
        
        var verticalDivider: some View {
            Rectangle()
                .frame(width: 1, height: 44)
                .opacity(0.1)
        }
        
        var bodyStatus: some View {
            VStack(alignment: .leading) {
                HStack {
                    Text("身高")
                        .font(.system(size: 11))
                        .foregroundColor(.gray)
                    Text(model.height)
                        .font(.system(size: 11))
                        .foregroundColor(model.color)
                }
                HStack {
                    Text("体重")
                        .font(.system(size: 11))
                        .foregroundColor(.gray)
                    Text(model.weight)
                        .font(.system(size: 11))
                        .foregroundColor(model.color)
                }
            }
        }
        
        var typeInfo: some View {
            HStack {
                ForEach(model.types) { type in
                    ZStack {
                        RoundedRectangle(cornerRadius: 7)
                            .fill(type.color)
                            .frame(width: 36, height: 14)
                        Text(type.name)
                            .font(.system(size: 10))
                            .foregroundColor(.white)
                    }
                }
            }
        }
        
        var body: some View {
            HStack(spacing: 18) {
                pokemonIcon
                nameSpecies
                verticalDivider
                
                VStack(spacing: 12) {
                    bodyStatus
                    typeInfo
                }
            }
        }
    }
}

struct PokemonInfoPanelOverlay: View {
    let model: PokemonViewModel
    
    var body: some View {
        VStack {
            Spacer()
            PokemonInfoPanel(model: model)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct PokemonInfoPanel_Previews: PreviewProvider {
    static var previews: some View {
        PokemonInfoPanel(model: .sample(id: 1))
    }
}
