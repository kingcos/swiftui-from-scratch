//
//  ContentView.swift
//  objccn-swiftui
//
//  Created by kingcos on 2019/12/30.
//  Copyright © 2019 kingcos. All rights reserved.
//

import SwiftUI

let scale: CGFloat = UIScreen.main.bounds.width / 414

struct ContentView: View {
    // @State 修饰的值将被转换为 getter & setter；
    // @State 适用于声明值类型变量，当其值改变时将触发 UI 刷新（非全局刷新），
    // 且条件为：所有相关操作和状态改变都应和当前 View 挂钩（在 body 或 body 所调用的方法中访问）
    // 若在多个 View 中共享数据，或需要在 View 外部操作数据，则不可使用 @State
    @State private var brain: CalculatorBrain = .left("0") // init(initialValue value: Value)
    
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
        
        VStack(spacing: 12) {
            Spacer() // 使用 Spacer 下沉视图
            Text(brain.output) // Text("0")
                .font(.system(size: 76))
                .minimumScaleFactor(0.5)
                .padding(.trailing, 24)
                .lineLimit(1)
                .frame(
                  minWidth: 0,         // 宽度最小范围
                  maxWidth: .infinity, // 宽度范围（尽可能地宽）
                  alignment: .trailing
                ) // 使用 frame 将文本推向右对齐
//            Button("Test") {
//                self.brain = .left("1.23")
//            }
            
            // 投影属性（projection property）在由 @ 修饰的属性之前使用 $ 所取得的值
            // @State 和 @Binding 的投影属性即自身所对应值的 Binding 类型（并非所有的 @ 属性都提供 $ 的投影访问方式）
            // $brain -> Binding
            CalculatorButtonPad(brain: $brain)
                .padding(.bottom)
        }
        .scaleEffect(scale)
        
//        VStack(spacing: 12) {
//            HStack() {
//                Spacer() // 使用 Spacer 将文本推向右对齐
//                Text("0")
//                    .font(.system(size: 76))
//                    .minimumScaleFactor(0.5)
//                    .padding(.trailing, 24)
//                    .lineLimit(1)
//            }
//            CalculatorButtonPad()
//                .padding(.bottom)
//        }
//        .frame(
//            minHeight: 0,
//            maxHeight: .infinity, // 高度范围（尽可能地宽）
//            alignment: .bottom
//        ) // 使用 frame 下沉视图
//        .scaleEffect(scale)
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

//MARK: ---

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
            // 注意 background 与 cornerRadius 顺序不能颠倒，否则先抠圆角再填充背景会导致圆角无效
        }
    }
    
    // 使用 ZStack 纵向堆叠
//    var body: some View {
//        ZStack {
//            Circle()
//                .foregroundColor(Color(backgroundColorName))
//                .frame(width: size.width, height: size.height)
//            Text(title)
//                .font(.system(size: fontSize))
//                .foregroundColor(.white)
//        }
//    }
}

struct CalculatorButtonRow : View {
    // 传递路径：ContentView @State -> CalculatorButtonPad @Binding -> CalculatorButtonRow @Binding
    // 对被声明为 @Binding 的属性进行赋值，改变的将不是属性本身，而是它的原始引用，这个改变将被向外传递。
    // 对内部 brain 的修改将导致外界 brain 改变，并刷新 UI。
    @Binding var brain: CalculatorBrain
    
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
                    self.brain = self.brain.apply(item: item)
                }
            }
        }
    }
}

struct CalculatorButtonPad: View {
    @Binding var brain: CalculatorBrain
    
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
                CalculatorButtonRow(brain: self.$brain, row: row)
            }
        }
    }
}
