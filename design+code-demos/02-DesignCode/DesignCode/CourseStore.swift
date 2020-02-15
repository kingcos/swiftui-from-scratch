//
//  CourseStore.swift
//  DesignCode
//
//  Created by kingcos on 2020/2/15.
//  Copyright © 2020 kingcos. All rights reserved.
//

import Foundation
import Contentful

// INPUT YOUR KEYS
let client = Client(spaceId: "", accessToken: "")

func getArray() {
    let query = Query.where(contentTypeId: "course")
    
    client.fetchArray(of: Entry.self, matching: query) { result in
        print(result)
    }
}
