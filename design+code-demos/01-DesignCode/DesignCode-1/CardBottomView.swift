//
//  CardBottomView.swift
//  DesignCode-1
//
//  Created by kingcos on 2020/2/3.
//  Copyright © 2020 kingcos. All rights reserved.
//

import SwiftUI

struct CardBottomView : View {
    var text = "5 years ago, I couldn’t write a single line of Swift. I learned it and moved to React, Flutter while using increasingly complex design tools. I don’t regret learning them because SwiftUI takes all of their best concepts. It is hands-down the best way for designers to take a first step into code."
    
    var body: some View {
        ZStack {
            BlurView(style: .extraLight)
            
            VStack {
                Rectangle()
                    .frame(width: 60, height: 6)
                    .cornerRadius(3.0)
                    .opacity(0.3)
                    .padding(.top, 16)
                VStack {
                    Text(text)
                        .foregroundColor(Color("background2"))
                        .lineLimit(100)
                        .padding(20)
                    Spacer()
                }
            }
            .background(Color(hue: 1, saturation: 0, brightness: 1, opacity: 0.5))
            .cornerRadius(30)
            .shadow(radius: 20)
        }
    }
}

struct CardBottomView_Previews: PreviewProvider {
    static var previews: some View {
        CardBottomView()
    }
}

//struct CardBottomView : View {
//    var body: some View {
//        VStack(spacing: 20.0) {
//            Rectangle()
//                .frame(width: 60, height: 6)
//                .cornerRadius(3.0)
//                .opacity(0.1)
//            Text("This certificate is proof that Meng To has achieved the UI Design course with approval from a Design+Code instructor.")
//                .lineLimit(10)
//            Spacer()
//        }
//        .frame(minWidth: 0, maxWidth: .infinity)
//        .padding()
//        .padding(.horizontal)
//        .background(BlurView(style: .systemMaterial)) // 适配黑夜模式
//        .cornerRadius(30)
//        .shadow(radius: 20)
//            .offset(y: UIScreen.main.bounds.height - 170)
//    }
//}
