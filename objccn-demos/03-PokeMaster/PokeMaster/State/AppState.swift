//
//  AppState.swift
//  PokeMaster
//
//  Created by kingcos on 2020/4/13.
//  Copyright © 2020 OneV's Den. All rights reserved.
//

import Foundation
import Combine

struct AppState {
    // 局部 Settings 类型
    var settings = Settings()
    
    var pokemonList = PokemonList()
}

extension AppState {
    struct Settings {
        enum Sorting: String, CaseIterable {
            case id, name, color, favorite
        }
        
        enum AccountBehavior: CaseIterable {
            case register, login
        }
        
        @UserDefaultsStorage(key: "showEnglishName", defaultValue: false)
        var showEnglishName
        
        @UserDefaultsStorage(key: "sorting", defaultValue: Sorting.id)
        var sorting
        
        var showFavoriteOnly = false
        
        var isEmailValid: Bool = false
        var isPasswordValid: Bool = false
        var isRegisterValid: Bool = false
        
        // 转为 AccountChecker 内
//        var accountBehavior = AccountBehavior.login
//        var email = ""
//        var password = ""
//        var verifyPassword = ""
        
        // 登录用户状态
        @FileStorage(directory: .documentDirectory, fileName: "user.json")
        var loginUser: User?
//        var loginUser: User? = try? FileHelper.loadJSON(from: .documentDirectory, fileName: "user.json") {
//            didSet {
//                if let user = loginUser {
//                    try? FileHelper.writeJSON(user, to: .documentDirectory, fileName: "user.json")
//                } else {
//                    try? FileHelper.delete(from: .documentDirectory, fileName: "user.json")
//                }
//            }
//        }
        // 登录请求中
        var loginRequesting = false
        // State -> 登录错误弹窗 UI
        var loginError: AppError?
        
        class AccountChecker {
            // class 的属性才可以声明为 @Published
            @Published var accountBehavior = AccountBehavior.login
            @Published var email = ""
            @Published var password = ""
            @Published var verifyPassword = ""
            
            var isEmailValid: AnyPublisher<Bool, Never> {
                let remoteVerify = $email
                    // 防抖（500 毫秒内无新值则发射）
                    .debounce(for: .milliseconds(500),
                              scheduler: DispatchQueue.main)
                    // 去重
                    .removeDuplicates()
                    .flatMap { email -> AnyPublisher<Bool, Never> in
                        // 正则校验是否合法
                        let validEmail = email.isValidEmailAddress
                        // 是否可跳过（登录状态可跳过重复性检查）
                        let canSkip = self.accountBehavior == .login
                        
                        switch (validEmail, canSkip) {
                        case (false, _):
                            // 邮箱不符合，则直接无效
                            return Just(false).eraseToAnyPublisher()
                            
                        case (true, false):
                            // 邮箱符合 && 非登录，则检查邮箱
                            return EmailCheckingRequest(email: email)
                                .publisher
                                .eraseToAnyPublisher()
                        case (true, true):
                            return Just(true).eraseToAnyPublisher()
                        }
                    }
                
                let emailLocalValid = $email.map { $0.isValidEmailAddress }
                let canSkipRemoteVerify = $accountBehavior.map { $0 == .login }
                
                return Publishers.CombineLatest3(emailLocalValid, canSkipRemoteVerify, remoteVerify)
                    .map { $0 && ($1 || $2) }
                    .eraseToAnyPublisher()
            }
            
            var isPasswordValid: AnyPublisher<Bool, Never> {
                let isPasswordNotEmpty = $password
                    .map { !$0.isEmpty }
//                    .print("isPasswordNotNull")
                
                let isVerifyPasswordNotEmpty = $verifyPassword
                    .map { !$0.isEmpty }
//                    .print("isVerifyPasswordNotNull")
                
                let isEqual = $password.combineLatest($verifyPassword).map { $0.0 == $0.1 }
                let canSkip = $accountBehavior.map { $0 == .login } // .print("canSkip")
                
                return Publishers.CombineLatest4(canSkip, isPasswordNotEmpty, isVerifyPasswordNotEmpty, isEqual).map {
                    $0 || ($1 && $2 && $3)
                }.eraseToAnyPublisher()
            }
            
            var isRegisterValid: AnyPublisher<Bool, Never> {
                return isEmailValid.combineLatest(isPasswordValid).map { $0 && $1 }.eraseToAnyPublisher()
            }
        }
        
        var checker = AccountChecker()
    }
}

extension AppState {
    struct PokemonList {
        @FileStorage(directory: .cachesDirectory, fileName: "pokemons.json")
        var pokemons: [Int: PokemonViewModel]?
        var loadingPokemons = false
        
        // 按 ID 排序的 Pokemon
        var allPokemonsByID: [PokemonViewModel] {
            guard let pokemons = pokemons?.values else { return [] }
            
            return pokemons.sorted { $0.id < $1.id }
        }
    }
}
