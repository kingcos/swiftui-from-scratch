//
//  DisposeBag.swift
//  PokeMaster
//
//  Created by kingcos on 2020/4/18.
//  Copyright © 2020 OneV's Den. All rights reserved.
//

import Foundation
import Combine

// https://github.com/ReactiveX/RxSwift/blob/master/Documentation/GettingStarted.md
class DisposeBag {
    private var values: [AnyCancellable] = []
    
    func add(_ value: AnyCancellable) {
        values.append(value)
    }
}

extension AnyCancellable {
    func add(to bag: DisposeBag) {
        bag.add(self)
    }
}
