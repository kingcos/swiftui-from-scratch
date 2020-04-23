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
    
    func makeUIViewController(
        context: Context
    ) -> SFSafariViewController {
        let controller = SFSafariViewController(url: url)
        return controller
    }
    
    func updateUIViewController(
        _ uiViewController: SFSafariViewController, context: Context
    ) {}
}
