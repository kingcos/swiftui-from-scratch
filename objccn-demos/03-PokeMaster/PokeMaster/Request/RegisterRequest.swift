//
//  RegisterRequest.swift
//  PokeMaster
//
//  Created by kingcos on 2020/4/19.
//  Copyright © 2020 OneV's Den. All rights reserved.
//

import Foundation
import Combine

struct RegisterRequest {
    let email: String
    let password: String
    
    var publisher: AnyPublisher<User, AppError> {
        Future { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
                if self.email == "a@a.com" {
                    promise(.failure(.userAlreadyExists))
                } else {
                    promise(.success(User(email: self.email,
                                          favoritePokemonIDs: [])))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
