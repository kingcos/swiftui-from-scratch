//
//  OverlaySheet.swift
//  PokeMaster
//
//  Created by kingcos on 2020/4/23.
//  Copyright © 2020 OneV's Den. All rights reserved.
//

import SwiftUI

struct OverlaySheet<Content: View>: View {
    private let isPresented: Binding<Bool>
    private let makeContent: () -> Content
    
    init(isPresented: Binding<Bool>,
         @ViewBuilder content: @escaping () -> Content) {
        self.isPresented = isPresented
        self.makeContent = content
    }
    
    var body: some View {
        VStack {
            Spacer()
            makeContent()
        }
        .offset(y: isPresented.wrappedValue ? 0 : UIScreen.main.bounds.height) // 未展示时，设置 offset 以隐藏
        .edgesIgnoringSafeArea(.bottom)
    }
}

extension View {
    func overlaySheet<Content: View>(isPresented: Binding<Bool>,
                                     @ViewBuilder content: @escaping () -> Content) -> some View {
        overlay(OverlaySheet(isPresented: isPresented, content: content))
    }
}
