//
//  PokemonInfoRow.swift
//  PokeMaster
//
//  Created by kingcos on 2020/3/18.
//  Copyright © 2020 OneV's Den. All rights reserved.
//

import SwiftUI

struct ToolButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 25)) // 不会改变 frame
            .foregroundColor(.white)
            .frame(width: 30, height: 30) // 自定 frame 以方便用户点击
    }
}

struct PokemonInfoRow: View {
    //    let model = PokemonViewModel.sample(id: 1)
    let model: PokemonViewModel
    
//    @State var expanded: Bool
    let expanded: Bool
    
    var body: some View {
        VStack {
            HStack {
                Image("Pokemon-\(model.id)")
                    .resizable() // 默认图片绘制与 frame 无关
                    .frame(width: 50, height: 50)
                    .aspectRatio(contentMode: .fit) // 保持原始比例
                    .shadow(radius: 4)
                Spacer()
                VStack(alignment: .trailing) {
                    Text(model.name)
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                    Text(model.nameEN)
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
            }
            .padding(.top, 12)
            Spacer()
            HStack(spacing: expanded ? 20 : -30) {
                Spacer()
                Button(action: {
                    print("fav")
                }) {
                    Image(systemName: "star")
                        .modifier(ToolButtonModifier())
                }
                Button(action: {
                    print("panel")
                }) {
                    Image(systemName: "chart.bar")
                        .modifier(ToolButtonModifier())
                }
                Button(action: {
                    print("web")
                }) {
                    Image(systemName: "info.circle")
                        .modifier(ToolButtonModifier())
                }
            }
            .padding(.bottom, 12)
            .opacity(expanded ? 1.0 : 0.0)
            .frame(maxHeight: expanded ? .infinity : 0)
        }
        .frame(height: expanded ? 120 : 80)
        .padding(.leading, 23)
        .padding(.trailing, 15)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 20) // 遵守 Shape 协议
                    // 边框
                    .stroke(model.color, style: StrokeStyle(lineWidth: 4))
                RoundedRectangle(cornerRadius: 20) // 遵守 Shape 协议
                    // 渐变色
                    .fill(LinearGradient(gradient: Gradient(colors: [.white, model.color]),
                                         startPoint: .leading,
                                         endPoint: .trailing
                    )
                )
            }
        )
        .padding(.horizontal)
//        .animation(
//            .spring(response: 0.55,
//                    dampingFraction: 0.425,
//                    blendDuration: 0)
//        ) // 隐式动画
        
//        .onTapGesture {
//            self.expanded.toggle()
//
//            // 动画
////            let animation = Animation
////                .linear(duration: 0.5)
////                .delay(0.2)
////                .repeatForever(autoreverses: true)
////            withAnimation(animation) {
////                self.expanded.toggle()
////            }
//        }
    }
}

struct PokemonInfoRow_Previews: PreviewProvider {
    static var previews: some View {
        PokemonInfoRow(model: .sample(id: 1), expanded: false)
    }
}
