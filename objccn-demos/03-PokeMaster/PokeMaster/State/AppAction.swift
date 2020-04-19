//
//  AppAction.swift
//  PokeMaster
//
//  Created by kingcos on 2020/4/18.
//  Copyright © 2020 OneV's Den. All rights reserved.
//

import Foundation

enum AppAction {
    case login(email: String, password: String)
    case register(email: String, password: String)
    case logout
    
    case accountBehaviorDone(result: Result<User, AppError>)
    
    case emailValid(valid: Bool)
    case passwordValid(valid: Bool)
    case registerValid(valid: Bool)
    
    case loadPokemons
    case loadPokemonsDone(result: Result<[PokemonViewModel], AppError>)
    
    case clearCache
}
