//
//  SafariView.swift
//  PokeMaster
//
//  Created by kingcos on 2020/4/24.
//  Copyright © 2020 OneV's Den. All rights reserved.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    
    typealias Context = UIViewControllerRepresentableContext<SafariView>
    
    let url: URL
    let onFinished: () -> Void
    
    class Coordinator: NSObject, SFSafariViewControllerDelegate {
        let parent: SafariView
        
        init(_ parent: SafariView) {
            self.parent = parent
        }
        
        func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
            // 将代理方法传递出去
            parent.onFinished()
        }
    }
    
    // 可返回任意类型的对象，可被设置到 context.coordinator 中
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(
        context: Context
    ) -> SFSafariViewController {
        let controller = SFSafariViewController(url: url)
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(
        _ uiViewController: SFSafariViewController, context: Context
    ) {}
}
