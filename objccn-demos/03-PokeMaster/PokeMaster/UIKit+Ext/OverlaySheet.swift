//
//  OverlaySheet.swift
//  PokeMaster
//
//  Created by kingcos on 2020/4/23.
//  Copyright © 2020 OneV's Den. All rights reserved.
//

import SwiftUI

// 手势组合：
// 1. https://developer.apple.com/documentation/swiftui/sequencegesture
// 2. https://developer.apple.com/documentation/swiftui/simultaneousgesture
// 3. https://developer.apple.com/documentation/swiftui/exclusivegesture

struct OverlaySheet<Content: View>: View {
    private let isPresented: Binding<Bool>
    private let makeContent: () -> Content
    
    // 使用私有 @State，仅在 View 维护状态也可
//    @State private var translation = CGPoint.zero
//    @State 与 @GestureState 区别：后者的值会被隐式地置为初始值
    @GestureState private var translation = CGPoint.zero
    
    init(isPresented: Binding<Bool>,
         @ViewBuilder content: @escaping () -> Content) {
        self.isPresented = isPresented
        self.makeContent = content
    }
    
    var panelDraggingGesture: some Gesture {
        // @State 可通过 onChanged 设定
//        DragGesture()
//            .onChanged { state in
//                self.translation = CGPoint(x: 0, y: state.translation.height)
//            }
        
        DragGesture()
            .updating($translation) { current, state, _ in
                // 只调整纵轴
                state.y = current.translation.height
            }
            .onEnded { state in
                // 手势结束时，判定是否要关闭面板
                if state.translation.height > 250 {
                    self.isPresented.wrappedValue = false
                }
            }
    }
    
    var body: some View {
        VStack {
            Spacer()
            makeContent()
        }
        .offset(
            y: (isPresented.wrappedValue ?
                0 : UIScreen.main.bounds.height) // 未展示时，设置 offset 以隐藏
            + max(0, translation.y)
        )
        .animation(.interpolatingSpring(stiffness: 70, damping: 12))
        .edgesIgnoringSafeArea(.bottom)
        .gesture(panelDraggingGesture)
    }
}

extension View {
    func overlaySheet<Content: View>(isPresented: Binding<Bool>,
                                     @ViewBuilder content: @escaping () -> Content) -> some View {
        overlay(OverlaySheet(isPresented: isPresented, content: content))
    }
}
