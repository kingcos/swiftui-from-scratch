//
//  AppCommand.swift
//  PokeMaster
//
//  Created by kingcos on 2020/4/18.
//  Copyright © 2020 OneV's Den. All rights reserved.
//

import Foundation
import Combine

// 负责需要执行的副作用

protocol AppCommand {
    func execute(in store: Store)
}

class SubscriptionToken {
    var cancellable: AnyCancellable?
    func unseal() {
        cancellable = nil
        // 非必须，当 token 离开作用域释放，cancellable 也会释放
    }
}

extension AnyCancellable {
    func seal(in token: SubscriptionToken) {
        token.cancellable = self
    }
}

struct LoginAppCommand: AppCommand {
    let email: String
    let password: String
    
    func execute(in store: Store) {
//        let token = SubscriptionToken()
//
//        // Result of call to 'sink(receiveCompletion:receiveValue:)' is unused
//        LoginRequest(email: email, password: password)
//            .publisher
//            .sink(
//                receiveCompletion: { complete in
//                    // 出错结束
//                    if case .failure(let error) = complete {
//                        store.dispatch(.accountBehaviorDone(result: .failure(error)))
//                    }
//
//                    token.unseal() // 释放 AnyCancellable
//                },
//                receiveValue: { user in
//                    // 成功
//                    store.dispatch(.accountBehaviorDone(result: .success(user)))
//                }
//            )
//            .seal(in: token) // 将返回值 AnyCancellable 存储在 token 中
        
        LoginRequest(email: email, password: password)
            .publisher
            .print()
            .sink(
                receiveCompletion: { complete in
                    // 出错结束
                    if case .failure(let error) = complete {
                        store.dispatch(.accountBehaviorDone(result: .failure(error)))
                    }
                },
                receiveValue: { user in
                    // 成功
                    store.dispatch(.accountBehaviorDone(result: .success(user)))
                }
            )
            .add(to: store.disposeBag)
//            .store(in: &store.subs)
    }
}

// 纯副作用
//struct WriteUserAppCommand: AppCommand {
//    let user: User
//
//    func execute(in store: Store) {
//        try? FileHelper.writeJSON(user, to: .documentDirectory, fileName: "user.json")
//    }
//}
