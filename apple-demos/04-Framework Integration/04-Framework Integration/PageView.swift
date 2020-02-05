//
//  PageView.swift
//  04-Framework Integration
//
//  Created by kingcos on 2020/2/6.
//  Copyright © 2020 kingcos. All rights reserved.
//

import SwiftUI

struct PageView<Page: View>: View {
    @State var currentPage = 1 // 可改变起始页
    
    // UIHostingController 是 UIViewController 的子类，表示 UIKit 上下文中的 SwiftUI 视图
    var viewControllers: [UIHostingController<Page>]
    
    init(_ views: [Page]) {
        self.viewControllers = views.map { UIHostingController(rootView: $0) }
    }
    
    var body: some View {
//        VStack {
//            PageViewController(controllers: viewControllers, currentPage: $currentPage)
//            Text("Current Page: \(currentPage)")
//        }
        
        ZStack(alignment: .bottomTrailing) {
            PageViewController(controllers: viewControllers, currentPage: $currentPage)
            PageControl(numberOfPages: viewControllers.count, currentPage: $currentPage)
                .padding(.trailing)
        }
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView(features.map { FeatureCard(scene: $0) })
            .aspectRatio(3/2, contentMode: .fit)
    }
}
