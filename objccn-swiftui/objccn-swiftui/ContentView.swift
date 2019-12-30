//
//  ContentView.swift
//  objccn-swiftui
//
//  Created by kingcos on 2019/12/30.
//  Copyright © 2019 kingcos. All rights reserved.
//

import SwiftUI

struct CalculatorButton : View {
    let fontSize: CGFloat = 38
    let title: String
    let size: CGSize
    let backgroundColorName: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: fontSize))
                .foregroundColor(.white)
                .frame(width: size.width, height: size.height)
                .background(Color(backgroundColorName))
                .cornerRadius(size.width / 2)
        }
    }
}

struct CalculatorButtonRow : View {
    let row: [CalculatorButtonItem]
    
    var body: some View {
        HStack {
            // ForEach 列举元素，并返回视图集合；id 需遵守 Hashable 协议
            // \.self 会根据上下文推断为 CalculatorButtonItem，即 \CalculatorButtonItem.self
            // Swift 中任一值都拥有一个特殊的伪属性，.self，该值本身引用了整个值：
            // var x = 1
            // x.self = 2 // x.self == 2, x == 2
            // let id = \Int.self; x[keyPath: id] = 3 // x[keyPath: id] == 3, x == 3
            ForEach(row, id: \.self) { item in
                CalculatorButton(
                    title: item.title,
                    size: item.size,
                    backgroundColorName: item.backgroundColorName)
                {
                    print("Button: \(item.title)")
                }
            }
        }
    }
}

struct CalculatorButtonPad: View {
    let pad: [[CalculatorButtonItem]] = [
        [.command(.clear), .command(.flip), .command(.percent), .op(.divide)],
        [.digit(7), .digit(8), .digit(9), .op(.multiply)],
        [.digit(4), .digit(5), .digit(6), .op(.minus)],
        [.digit(1), .digit(2), .digit(3), .op(.plus)],
        [.digit(0), .dot, .op(.equal)]
    ]
    
    var body: some View {
        VStack(spacing: 8) {
            ForEach(pad, id: \.self) { row in
                CalculatorButtonRow(row: row)
            }
        }
    }
}

struct ContentView: View {
    let row: [CalculatorButtonItem] = [
        .digit(1), .digit(2), .digit(3), .op(.plus),
    ]
    
    var body: some View {
//        Text("+")
//            .font(.title)             // 1
//            .foregroundColor(.white)  // 2
//            .padding()                // 3
//            .background(Color.orange) // 4
        // 1-4 被称为 View Modifier：作用在某个 View 上，并生成原来值的另一个版本
        // 1 & 2：定义在具体类型（如 Text），返回也是具体类型（如 Text）
        // 3 & 4：定义在 View 扩展中，返回则是新的 View 封装类（some View）
        // 因此如果先使用 3 | 4 则无法使用 1 | 2，需要注意顺序
        // https://developer.apple.com/documentation/uikit/uifont/scaling_fonts_automatically
        
        CalculatorButtonPad()
    }
//        Button(action: {
//          print("Button: +")
//        }) {
//          Text("+")
//              .font(.system(size: 38))
//              .foregroundColor(.white)
//              .frame(width: 88, height: 88)            // 5
//              .background(Color("operatorBackground"))
//              .cornerRadius(44)
//          // 5：通过 Assets 引用颜色的好处有：
//          //   - 1. 可以用同一个名称但根据使用环境不同而使用不同的色值（比如 iPhone & iPad，亮色与暗色等）
//          //   - 2. 直接使用 8 位十六进制的颜色值
//        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
