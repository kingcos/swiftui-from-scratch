//
//  AppState.swift
//  PokeMaster
//
//  Created by kingcos on 2020/4/13.
//  Copyright © 2020 OneV's Den. All rights reserved.
//

import Foundation

struct AppState {
    // 局部 Settings 类型
    var settings = Settings()
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
        }
        
        var checker = AccountChecker()
    }
}
