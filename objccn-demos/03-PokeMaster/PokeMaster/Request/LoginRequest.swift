//
//  LoginRequest.swift
//  PokeMaster
//
//  Created by kingcos on 2020/4/18.
//  Copyright © 2020 OneV's Den. All rights reserved.
//

import Foundation
import Combine

enum AppError: Error, Identifiable {
    // 更建议 Error Code 作为错误 ID
    var id: String { localizedDescription }
    
    case passwordWrong
    case networkingFailed(Error)
    case userAlreadyExists
}

extension AppError {
    var localizedDescription: String {
        switch self {
        case .passwordWrong:
            return "密码错误"
        case .userAlreadyExists:
            return "该用户已存在"
        case .networkingFailed(let err):
            return "网络错误：\(err.localizedDescription)"
        }
    }
}

struct LoginRequest {
    let email: String
    let password: String
    
//    var publisher: AnyPublisher<User, AppError> {
//        // 通过 Future 将异步变同步
//        Future { promise in
//            DispatchQueue.global().asyncAfter(deadline: .now() + 1.5) { // 模拟网络请求
//                if self.password == "password" {
//                    let user = User(email: self.email, favoritePokemonIDs: [])
//                    promise(.success(user))
//                } else {
//                    promise(.failure(.passwordWrong))
//                }
//            }
//            
//        }
//        .receive(on: DispatchQueue.main)
//        .eraseToAnyPublisher()
//    }
    
    var publisher: AnyPublisher<User, AppError> {
        Future { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 1.5) {
                if self.password == "password" {
                    let user = User(email: self.email, favoritePokemonIDs: [])
                    promise(.success(user))
                } else {
                    promise(.failure(.passwordWrong))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
