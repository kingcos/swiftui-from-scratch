//
//  CircleImage.swift
//  01-SwiftUI Essentials
//
//  Created by kingcos on 2020/2/4.
//  Copyright © 2020 kingcos. All rights reserved.
//

import SwiftUI

struct CircleImage: View {
    var image: Image

    var body: some View {
        image
            .frame(maxWidth: 260, maxHeight: 260) // 限制宽度
            .clipShape(Circle()) // 裁剪为圆
            .overlay(Circle().stroke(Color.white, lineWidth: 4)) // 添加边框
            .shadow(radius: 10) // 添加阴影
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image: Image("jingshangongyuan"))
    }
}
