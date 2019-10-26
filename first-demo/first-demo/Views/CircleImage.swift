//
//  CircleImage.swift
//  first-demo
//
//  Created by kingcos on 2019/10/26.
//  Copyright © 2019 kingcos. All rights reserved.
//

import SwiftUI

struct CircleImage: View {
    var body: some View {
        Image("jingshangongyuan")
            .resizable()
            .frame(width: 250, height: 250)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4.0))
            .shadow(radius: 10.0)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage()
    }
}
