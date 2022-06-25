//
//  HikeView.swift
//  02-Drawing and Animation
//
//  Created by kingcos on 2020/2/4.
//  Copyright © 2020 kingcos. All rights reserved.
//

import SwiftUI

extension AnyTransition {
    // 抽离
    static var moveAndFade: AnyTransition {
//         AnyTransition.slide
//         AnyTransition.move(edge: .trailing)
        
        .asymmetric( // 非对称变换
            // 插入
            insertion: .move(edge: .trailing).combined(with: .opacity),
            // 移除
            removal: .scale.combined(with: .opacity)
        )
    }
}

struct HikeView: View {
    var hike: Hike
    @State private var showDetail = false
    
    var body: some View {
        VStack {
            HStack {
                HikeGraph(hike: hike, path: \.elevation)
                    .frame(width: 50, height: 30)
                    .animation(nil)
                
                VStack(alignment: .leading) {
                    Text(hike.name)
                        .font(.headline)
                    Text(hike.distanceText)
                }
                
                Spacer()

//                Button(action: {
//                    // withAnimation(.easeInOut(duration: 4)) {
//                    withAnimation {
//                        self.showDetail.toggle()
//                    }
//                }) {
//                    Image(systemName: "chevron.right.circle")
//                        .imageScale(.large)
//                        .rotationEffect(.degrees(showDetail ? 90 : 0))
//                        .scaleEffect(showDetail ? 1.5 : 1)
//                        .padding()
//                }
                Button {
//                    withAnimation(.easeInOut(duration: 4)) {
                    withAnimation {
                        // 受影响的视图均有动画
                        showDetail.toggle()
                    }
                } label: {
                    Label("Graph", systemImage: "chevron.right.circle")
                        .labelStyle(.iconOnly)
                        .imageScale(.large)
                        .rotationEffect(.degrees(showDetail ? 90 : 0))
//                        .animation(nil, value: showDetail) // 关闭旋转动画（上一个 modifier 的动画）
                        .scaleEffect(showDetail ? 1.5 : 1)
                        .padding()
//                        .animation(.easeInOut, value: showDetail)
//                        .animation(.spring(), value: showDetail)
                }
            }
            
            Spacer()

            if showDetail {
                HikeDetail(hike: hike)
                        .transition(.moveAndFade)
//                     .transition(.slide) // 滑动动画
            }
        }
    }
}

struct HikeView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HikeView(hike: ModelData().hikeData[0])
                .padding()
            Spacer()
        }
    }
}
