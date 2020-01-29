//
//  UpdateStore.swift
//  DesignCode
//
//  Created by kingcos on 2020/1/29.
//  Copyright © 2020 kingcos. All rights reserved.
//

import SwiftUI
import Combine

class UpdateStore: ObservableObject {
    @Published var updates: [Update] = updateData
    
}
