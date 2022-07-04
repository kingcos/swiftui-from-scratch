//
//  AlignmentView.swift
//  04-Layout
//
//  Created by kingcos on 2022/7/5.
//

import SwiftUI

// HStack 接受 VerticalAlignment，典型值为 .top、.center、.bottom、lastTextBaseline 等
// VStack 接受 HorizontalAlignment，典型值为 .leading、.center 和 .trailing
// ZStack 在两个方向上都有对齐的需求，它接受 Alignment。Alignment 其实就是对 VerticalAlignment 和 HorizontalAlignment 组合的封装
// 默认均为 .center
struct AlignmentView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct AlignmentView_Previews: PreviewProvider {
    static var previews: some View {
        AlignmentView()
    }
}
