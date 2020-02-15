//
//  DataStore.swift
//  DesignCode
//
//  Created by kingcos on 2020/2/15.
//  Copyright © 2020 kingcos. All rights reserved.
//

import Foundation
import Combine

class DataStore: ObservableObject {
    @Published var posts: [Post] = []
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        API().getPosts { (posts) in
            self.posts = posts
        }
    }
}
