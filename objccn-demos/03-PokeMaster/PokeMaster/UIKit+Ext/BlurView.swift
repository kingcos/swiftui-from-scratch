//
//  BlurView.swift
//  PokeMaster
//
//  Created by kingcos on 2020/3/19.
//  Copyright © 2020 OneV's Den. All rights reserved.
//

import SwiftUI
import UIKit

struct BlurView: UIViewRepresentable {
    let style: UIBlurEffect.Style
    
    init(style: UIBlurEffect.Style) {
        print("init")
        
        self.style = style
    }
    
    func makeUIView(
        context: UIViewRepresentableContext<BlurView>
    ) -> UIView {
        print("makeUIView")
        
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blurView)
        
        // AutoLayout
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        return view
    }
    
    func updateUIView(
        _ uiView: UIView,
        context: UIViewRepresentableContext<BlurView>
    ) {
        // style 被设置时调用，要更新 UI
        print("updateUIView")
        guard let subview = uiView.subviews.first,
              let blurView = subview as? UIVisualEffectView else { return }
        
        let blurEffect = UIBlurEffect(style: style)
        blurView.effect = blurEffect
    }
}

extension View {
    func blurBackground(style: UIBlurEffect.Style) -> some View {
        ZStack {
            BlurView(style: style)
            self
        }
    }
}

struct BlurView_Previews: PreviewProvider {
    static var previews: some View {
        BlurView(style: .dark)
    }
}
