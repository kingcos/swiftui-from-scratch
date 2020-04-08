//
//  BlurView.swift
//  PokeMaster
//
//  Created by kingcos on 2020/3/19.
//  Copyright © 2020 OneV's Den. All rights reserved.
//

import SwiftUI
import UIKit

// 首次
//init
//makeUIView
//updateUIView
//updateUIView

// 切换时，重新计算，重新渲染（但注意没有 makeUIView）
//init
//updateUIView

struct BlurView: UIViewRepresentable {
    let style: UIBlurEffect.Style
    
    init(style: UIBlurEffect.Style) {
        print("init")
        
        self.style = style
    }
    
    func makeUIView(
        context: UIViewRepresentableContext<BlurView>
    ) -> UIView {
//        需返回要封装的 UIView 类型
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
//        在 UIViewRepresentable 中的某个属性发生变化，SwiftUI 要求更新该 UIKit 部件时被调用
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
