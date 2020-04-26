//
//  FlowRectangle.swift
//  PokeMaster
//
//  Created by kingcos on 2020/4/27.
//  Copyright © 2020 OneV's Den. All rights reserved.
//

import SwiftUI

// 可以通过 GeometryReader 读取父视图提供的一些高度、宽度等信息。
//@frozen public struct GeometryReader<Content> : View where Content : View {
//
//    public var content: (GeometryProxy) -> Content
//    // 构造方法需传入 ViewBuilder 闭包，但需要提供 GeometryProxy
//    @inlinable public init(@ViewBuilder content: @escaping (GeometryProxy) -> Content)
//
//    /// The type of view representing the body of this view.
//    ///
//    /// When you create a custom view, Swift infers this type from your
//    /// implementation of the required `body` property.
//    public typealias Body = Never
//}

// GeometryProxy 中包括了父视图层级向当前视图提议的布局信息
//public struct GeometryProxy {
//
//    /// The size of the container view.
//    public var size: CGSize { get }
//
//    /// Resolves the value of `anchor` to the container view.
//    public subscript<T>(anchor: Anchor<T>) -> T { get }
//
//    /// The safe area inset of the container view.
//    public var safeAreaInsets: EdgeInsets { get }
//
//    /// The container view's bounds rectangle converted to a defined
//    /// coordinate space.
//    public func frame(in coordinateSpace: CoordinateSpace) -> CGRect
//}

struct FlowRectangle: View {
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                Rectangle()
                    .fill(Color.red)
                    .frame(height: proxy.size.height * 0.3)
                HStack(spacing: 0) {
                    Rectangle()
                        .fill(Color.green)
                        .frame(width: proxy.size.width * 0.4)
                    VStack(spacing: 0) {
                        Rectangle()
                            .fill(Color.blue)
                            .frame(height: proxy.size.height * 0.4)

                        Rectangle()
                            .fill(Color.yellow)
                            .frame(height: proxy.size.height * 0.3)
                    }
                    .frame(width: proxy.size.width * 0.6)
                }
            }
        }
    }
}

struct FlowRectangle_Previews: PreviewProvider {
    static var previews: some View {
        FlowRectangle()
    }
}
