//
//  UpdateStore.swift
//  DesignCode-1
//
//  Created by kingcos on 2020/2/3.
//  Copyright © 2020 kingcos. All rights reserved.
//

import SwiftUI
import Combine

class UpdateStore : ObservableObject {
//    @Published var updates: [Update]
    
    var objectWillChange = PassthroughSubject<Void, Never>()

    var updates: [Update] {
        // willSet { objectWillChange.send() }
        didSet { objectWillChange.send() }
    }

    init(updates: [Update] = []) {
        self.updates = updates
    }
}
