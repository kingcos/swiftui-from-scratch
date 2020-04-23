//
//  ContentView.swift
//  PokeMaster
//
//  Created by Wang Wei on 2019/08/28.
//  Copyright © 2019 OneV's Den. All rights reserved.
//

import SwiftUI

// 多个视图共享 @State 容易出现问题（例如 isSFViewActive）
// 同样的情况也会发生在 List 的 cell 上使用 .sheet 以 modal 方式弹出的界面中。.sheet 最常见的用法是 sheet(isPresented:content:)，它需要 Binding 来决定展示与否，在实际 app 中更容易让人犯错。
// 在示例 app 里，我们使用了 cell 的 expanded 来判定是不是需要真的把 Binding 传递进去。另一种常见的解决方式是不要在列表 cell 上定义导航行为 (包括 NavigationLink 或 sheet)，而是将它们放到列表外层，这样就不会出现多个 cell 共用一个状态的情况了。在本章的练习中，我们会看到一个具体的例子。
struct ContentView : View {
    @State var show: Bool = false
    
    var body: some View {
        NavigationView {
            List(0..<10) { i in
                NavigationLink(
                    destination: Text("Detail \(i)"), isActive: self.$show)
                {
                    Text("Cell \(i)")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
