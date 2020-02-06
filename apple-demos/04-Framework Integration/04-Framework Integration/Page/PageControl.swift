//
//  PageControl.swift
//  04-Framework Integration
//
//  Created by kingcos on 2020/2/6.
//  Copyright © 2020 kingcos. All rights reserved.
//

import SwiftUI
import UIKit

// UIViewRepresentable and UIViewControllerRepresentable types have the same life cycle, with methods that correspond to their underlying UIKit types.
// 生命周期同 UIViewControllerRepresentable
struct PageControl: UIViewRepresentable {
    var numberOfPages: Int
    @Binding var currentPage: Int

    func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()
        control.numberOfPages = numberOfPages
        control.addTarget(
            context.coordinator,
            action: #selector(Coordinator.updateCurrentPage(sender:)),
            for: .valueChanged)
        
        return control
    }

    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPage
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // Because UIControl subclasses like UIPageControl use the target-action pattern instead of delegation, this Coordinator implements an @objc method to update the current page binding.
    class Coordinator: NSObject {
        var control: PageControl

        init(_ control: PageControl) {
            self.control = control
        }

        @objc func updateCurrentPage(sender: UIPageControl) {
            control.currentPage = sender.currentPage
        }
    }
}
