//
//  ContentView.swift
//  first-demo
//
//  Created by kingcos on 2019/10/26.
//  Copyright © 2019 kingcos. All rights reserved.
//

import SwiftUI

// 视图结构
struct ContentView: View {
    var body: some View {
        // body 内只能有一个元素
        VStack {
            MapView()
                .frame(height: 300)
                .edgesIgnoringSafeArea(.top)
            
            CircleImage()
                .offset(y: -150)
                .padding(.bottom, -150)
            
            VStack(alignment: .leading) {
                Text("北京")
                    .font(.title) // 这样的方法被称之为 modifiers（修饰器）
                HStack {
                    Text("万春亭")
                        .font(.subheadline)
                    Spacer() // 间隔
                    Text("景山公园")
                        .font(.subheadline)
                }
            }
            .padding() // 内边距
            
            Spacer()
        }
        
    }
}

// 便于预览使用 => 点击右侧 Resume 即可预览
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
