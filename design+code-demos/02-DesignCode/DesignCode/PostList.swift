//
//  PostList.swift
//  DesignCode
//
//  Created by kingcos on 2020/2/15.
//  Copyright © 2020 kingcos. All rights reserved.
//

import SwiftUI

struct PostList: View {
//    @State var posts: [Post] = []
    @ObservedObject var store = DataStore()
    
    var body: some View {
        List(store.posts) { post in
            VStack(alignment: .leading, spacing: 8.0) {
                Text(post.title).font(.system(.title, design: .serif)).bold()
                Text(post.body).font(.subheadline).foregroundColor(.secondary)
            }
        }
//        .onAppear {
//            API().getPosts { posts in
//                self.posts = posts
//            }
//        }
    }
}

struct PostList_Previews: PreviewProvider {
    static var previews: some View {
        PostList()
    }
}
