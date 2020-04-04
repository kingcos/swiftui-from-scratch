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
    // model 属性是观察的对象（视图 ObservedObject），model 是引用类型 CalculatorModel 的值，
    // 其中 objectWillChange 发出事件时，body 会被调用，UI 刷新
//    @ObservedObject private var model = CalculatorModel()
    
    // @EnvironmentObject 无需在构造函数中传递（不会在类型中自动创建变量）
    // 即可直接传递给当前 View 层级及其子层级中
    @EnvironmentObject var model: CalculatorModel
    
    @State private var editingHistory = false
    @State private var showingResult = false
    
    var body: some View {
        VStack(spacing: 12) {
            Spacer() // 使用 Spacer 下沉视图
//            Button("操作履历: \(model.history.count)") {
//                self.editingHistory = true
//            }.sheet(isPresented: self.$editingHistory) {
//                HistoryView(model: self.model, isPresented: self.$editingHistory)
//            }
            VStack {
                if model.totalCount == 0 {
                    Text("没有履历")
                } else {
                    HStack {
                        Text("履历").font(.headline)
                        Text("\(model.historyDetail)").lineLimit(nil)
                    }
                    HStack {
                        Text("显示").font(.headline)
                        Text("\(model.brain.output)")
                    }
                    Slider(
                        value: $model.slidingIndex,
                        in: 0...Float(model.totalCount),
                        step: 1
                    )
                }
            }.padding()
            
            Text(model.brain.output)
                .font(.system(size: 76))
                .minimumScaleFactor(0.5)
                .padding(.trailing, 24)
                .lineLimit(1)
                .frame(
                  minWidth: 0,         // 宽度最小范围
                  maxWidth: .infinity, // 宽度范围（尽可能地宽）
                  alignment: .trailing
                )
                .onTapGesture {
                    self.showingResult.toggle()
                }
                .alert(isPresented: self.$showingResult) {
                    Alert(title: Text(self.model.historyDetail),
                          message: Text(self.model.brain.output),
                          primaryButton: .default(Text("Copy"),
                                                  action: {
                                                    UIPasteboard.general.string = self.model.brain.output
                          }),
                          secondaryButton: .cancel())
                }
            
            // 通过动态查找的方式获取到对应的 Binding<CalculatorBrain> 传入
//            CalculatorButtonPad(brain: $model.brain)
            
//            CalculatorButtonPad(model: model)
            
            CalculatorButtonPad()
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
    // 外界传入 self.$brain
    // @Binding var brain: CalculatorBrain // Binding<CalculatorBrain>
    
    // var model: CalculatorModel
    @EnvironmentObject var model: CalculatorModel
    
    let row: [CalculatorButtonItem]
    
    var body: some View {
        HStack {
            ForEach(row, id: \.self) { item in
                CalculatorButton(
                    title: item.title,
                    size: item.size,
                    backgroundColorName: item.backgroundColorName)
                {
//                    self.brain = self.brain.apply(item: item)
                    // 点击之后不止一个操作（应用），那么就封装在 model 中
                    self.model.apply(item)
                }
            }
        }
    }
}

struct CalculatorButtonPad: View {
    // 外界传入 $model.brain
//    @Binding var brain: CalculatorBrain // Binding<CalculatorBrain>
    
    // var model: CalculatorModel
    
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
                // 再向下传入 CalculatorButtonRow
//                CalculatorButtonRow(brain: self.$brain, row: row)
                
//                CalculatorButtonRow(model: self.model, row: row)
                CalculatorButtonRow(row: row)
            }
        }
    }
}
