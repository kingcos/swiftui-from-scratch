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
    @State private var brain: CalculatorBrain = .left("0")
    
    let row: [CalculatorButtonItem] = [
        .digit(1), .digit(2), .digit(3), .op(.plus),
    ]
    
    var body: some View {
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
                )
            
            CalculatorButtonPad(brain: $brain)
                .padding(.bottom)
        }
        .scaleEffect(scale)
    }
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
        }
    }
}

struct CalculatorButtonRow : View {
    @Binding var brain: CalculatorBrain
    
    let row: [CalculatorButtonItem]
    
    var body: some View {
        HStack {
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
