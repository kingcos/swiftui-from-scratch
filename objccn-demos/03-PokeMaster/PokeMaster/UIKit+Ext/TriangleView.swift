//
//  TriangleView.swift
//  PokeMaster
//
//  Created by kingcos on 2020/4/26.
//  Copyright © 2020 OneV's Den. All rights reserved.
//

import SwiftUI

struct TriangleView: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            // 起点为左上角
            path.move(to: .zero)
            // 添加圆弧
            path.addArc(center: CGPoint(x: -rect.width / 5, y: rect.height / 2),
                        radius: rect.width / 2,
                        startAngle: .degrees(-45),
                        endAngle: .degrees(45),
                        clockwise: false)
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height / 2))
            // 闭合线段
            path.closeSubpath()
        }
    }
}

struct TriangleView_Previews: PreviewProvider {
    static var previews: some View {
        TriangleView()
            .fill(Color.green)
            .frame(width: 80, height: 80)
    }
}
