//
//  CourseStore.swift
//  DesignCode
//
//  Created by kingcos on 2020/2/15.
//  Copyright © 2020 kingcos. All rights reserved.
//

import Foundation
import Contentful
import Combine

// INPUT YOUR KEYS
let client = Client(spaceId: "", accessToken: "")

func getArray(id: String, completion: @escaping ([Entry]) -> ()) {
    let query = Query.where(contentTypeId: id)
    
    client.fetchArray(of: Entry.self, matching: query) { result in
        switch result {
        case .success(let array):
            DispatchQueue.main.async {
                completion(array.items)
            }
        case .error(let error):
            print(error)
        }
    }
}

class CourseStore: ObservableObject {
    @Published var courses: [Course] = courseData
    
    init() {
        getArray(id: "course") { (items) in
            items.forEach { (item) in
                self.courses.append(Course(title: item.fields["title"] as! String,
                                           subtitle: item.fields["subtitle"] as! String,
                                           image: #imageLiteral(resourceName: "Card4"),
                                           logo: #imageLiteral(resourceName: "Logo1"),
                                           color: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1),
                                           show: false))
            }
        }
    }
}
