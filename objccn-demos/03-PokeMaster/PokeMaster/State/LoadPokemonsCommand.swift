//
//  LoadPokemonsCommand.swift
//  PokeMaster
//
//  Created by kingcos on 2020/4/18.
//  Copyright © 2020 OneV's Den. All rights reserved.
//

import Foundation

struct LoadPokemonsCommand: AppCommand {
    func execute(in store: Store) {
        LoadPokemonRequest
            .all
            .sink(receiveCompletion: { complete in
                if case .failure(let error) = complete {
                    store.dispatch(.loadPokemonsDone(result: .failure(error)))
                }
            }, receiveValue: { value in
                store.dispatch(.loadPokemonsDone(result: .success(value)))
            })
            .add(to: store.disposeBag)
    }
}
