//
//  RegisterCommand.swift
//  PokeMaster
//
//  Created by kingcos on 2020/4/19.
//  Copyright © 2020 OneV's Den. All rights reserved.
//

import Foundation

struct RegisterCommand: AppCommand {
    let email: String
    let password: String
    
    func execute(in store: Store) {
        RegisterRequest(email: email, password: password)
            .publisher
            .sink(receiveCompletion: { complete in
                if case .failure(let error) = complete {
                    store.dispatch(.accountBehaviorDone(result: .failure(error)))
                }
            }, receiveValue: { user in
                store.dispatch(.accountBehaviorDone(result: .success(user)))
            })
            .add(to: store.disposeBag)
    }
}
