//
//  PokemonInfoRow.swift
//  PokeMaster
//
//  Created by kingcos on 2020/3/18.
//  Copyright © 2020 OneV's Den. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

// 自定义 ViewModifier
// .modifier(ToolButtonModifier()) 即可使用
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
    
    @EnvironmentObject var store: Store
    
    // 在 AppState 中统一管理
//    @State var isSFViewActive = false
    
    var body: some View {
        VStack {
            HStack {
//                Image("Pokemon-\(model.id)")
                KFImage(model.iconImageURL)
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
                    self.store.dispatch(.addToFavorite)
                }) {
                    Image(systemName: "star")
                        .modifier(ToolButtonModifier())
                }
                Button(action: {
                    let target = !self.store.appState.pokemonList.selectionState.panelPresented
                    self.store.dispatch(.togglePanelPresenting(presenting: target))
                }) {
                    Image(systemName: "chart.bar")
                        .modifier(ToolButtonModifier())
                }
//                Button(action: {
//                    print("web")
//                }) {
//                    Image(systemName: "info.circle")
//                        .modifier(ToolButtonModifier())
//                }
                
//                // NavigationLink 需在 NavigationView 内
//                NavigationLink(
//                    destination: SafariView(url: model.detailPageURL) {
////                        self.isSFViewActive = false
//                        self.store.dispatch(.closeSafariView)
//                    }
//                        .navigationBarTitle(Text(model.name),
//                                            displayMode: .inline),
//                    isActive: expanded ? $store.appState.pokemonList.isSFViewActive : .constant(false)
//                ) {
//                    Image(systemName: "info.circle")
//                        .modifier(ToolButtonModifier())
//                }
        
                Button(action: {
                    self.store.dispatch(.openSafariView(url: self.model.detailPageURL))
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
            // 渐变色背景
            ZStack {
                RoundedRectangle(cornerRadius: 20) // Shape >> View 遵守 Shape 协议
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
        .sheet(isPresented: $store.appState.pokemonList.isSFViewActive) {
            SafariView(url: self.store.appState.pokemonList.openURL!) {
                self.store.dispatch(.closeSafariView)
            }
        }
        .alert(isPresented: $store.appState.pokemonList.isShowLoginAlert) {
            Alert(title: Text("需要账户"), primaryButton: .cancel(), secondaryButton: .default(Text("登录"), action: {
                self.store.dispatch(.switchToSelection(selection: .settings))
            }))
        }

//        .animation(
//            .spring(response: 0.55,
//                    dampingFraction: 0.425,
//                    blendDuration: 0)
//        )
        // 隐式动画
        // 其作用范围很大：只要这个 View 甚至是它的子 View 上的可动画属性发生变化，这个动画就将适用。
        
//        .onTapGesture {
//            self.expanded.toggle()
//
//            // 动画
////            let animation = Animation
////                .linear(duration: 0.5)
////                .delay(0.2)
////                .repeatForever(autoreverses: true)
////            withAnimation(animation) { // 显式动画
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
