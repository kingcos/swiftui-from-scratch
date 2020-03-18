//
//  PokemonInfoRow.swift
//  PokeMaster
//
//  Created by 买明 on 2020/3/18.
//  Copyright © 2020 OneV's Den. All rights reserved.
//

import SwiftUI

struct PokemonInfoRow: View {
    let model = PokemonViewModel.sample(id: 1)
    
    var body: some View {
        VStack {
            HStack {
                Image("Pokemon-\(model.id)")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .aspectRatio(contentMode: .fit)
                    .shadow(radius: 4)
                Spacer()
                VStack {
                    Text(model.name)
                    Text(model.nameEN)
                }
            }
            HStack {
                Spacer()
                Button(action: {
                    
                }) {
                    Text("Fav")
                }
                Button(action: {
                    
                }) {
                    Text("Panel")
                }
                Button(action: {
                    
                }) {
                    Text("Web")
                }
            }
        }
        .background(Color.green)
    }
}

struct PokemonInfoRow_Previews: PreviewProvider {
    static var previews: some View {
        PokemonInfoRow()
    }
}
