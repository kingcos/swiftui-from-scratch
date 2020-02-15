//
//  Data.swift
//  DesignCode
//
//  Created by kingcos on 2020/2/15.
//  Copyright © 2020 kingcos. All rights reserved.
//

import Foundation

/*
 {
   "userId": 1,
   "id": 1,
   "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
   "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
 },
 */

struct Post: Codable, Identifiable {
    let id = UUID()
    let title: String
    let body: String
}

class API {
    func getPosts(completion: @escaping ([Post]) -> ()) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data,
                  let posts = try? JSONDecoder().decode([Post].self, from: data) else { return }
            
            DispatchQueue.main.async {
                completion(posts)
            }
        }
        .resume()
    }
}
