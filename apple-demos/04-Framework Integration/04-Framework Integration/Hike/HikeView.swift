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
        // AnyTransition.slide
        // AnyTransition.move(edge: .trailing)
        
        let insertion = AnyTransition
            .move(edge: .trailing)
            .combined(with: .opacity)
        let removal = AnyTransition
            .scale
            .combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
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

                Button(action: {
                    // withAnimation(.easeInOut(duration: 4)) {
                    withAnimation {
                        self.showDetail.toggle()
                    }
                }) {
                    Image(systemName: "chevron.right.circle")
                        .imageScale(.large)
                        .rotationEffect(.degrees(showDetail ? 90 : 0))
                        .scaleEffect(showDetail ? 1.5 : 1)
                        .padding()
                }
            }
            
            Spacer()

            if showDetail {
                HikeDetail(hike: hike)
                        .transition(.moveAndFade)
                    // .transition(.slide) // 滑动动画
            }
        }
    }
}

struct HikeView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HikeView(hike: hikeData[0])
                .padding()
            Spacer()
        }
    }
}
