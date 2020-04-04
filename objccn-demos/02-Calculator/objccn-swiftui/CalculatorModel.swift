//
//  CalculatorModel.swift
//  objccn-swiftui
//
//  Created by kingcos on 2020/1/14.
//  Copyright © 2020 kingcos. All rights reserved.
//

import Combine

// ObservableObject 相比 @State 更自由一些；必须使用 class
// CalculatorModel 自身是 ObservableObject 即可观察的对象（被观察者）
class CalculatorModel: ObservableObject {
    // 数据变化 -> objectWillChange -> View
    // 使用 @Published 时需注释 ⬇️
//    let objectWillChange = PassthroughSubject<Void, Never>()
    
//    var brain: CalculatorBrain = .left("0") {
//        // 手动在将要设置时调用 send
//        willSet {
//            objectWillChange.send()
//        }
//    }
    
    // 声明为 @Published 省略了 willSet 和 objectWillChange
    @Published var brain: CalculatorBrain = .left("0") // 初始为 0
    
    // 存储每一次操作的 Item
    @Published var history: [CalculatorButtonItem] = []
    
    // 将 history 转换为字符串
    var historyDetail: String {
        history.map { $0.description }.joined()
    }
    
    // 暂存被回溯的操作
    var temporaryKept: [CalculatorButtonItem] = []
    
    var totalCount: Int {
        history.count + temporaryKept.count
    }
    
    // 滑块的 index，[0, totalCount]，使用 Float 类型便于绑定到 UI
    var slidingIndex: Float = 0 {
        didSet {
            // 维护 history & temporaryKept
            keepHistory(upTo: Int(slidingIndex))
        }
    }
    
    func apply(_ item: CalculatorButtonItem) {
        brain = brain.apply(item: item) // 计算器显示、计算操作
        history.append(item) // 加入回溯历史
        
        temporaryKept.removeAll() // 移除暂存被回溯的操作
        slidingIndex = Float(totalCount) // 滑块 index 置为总数量（此时 didSet 重复做了一遍）
    }
    
    func keepHistory(upTo index: Int) {
        // 断言
        precondition(index <= totalCount, "Out of index.")
        
        let total = history + temporaryKept
        
        // 把所有的操作分为要回溯到的位置和要废弃的操作
        history = Array(total[..<index])
        temporaryKept = Array(total[index...])
        
        // 应用历史，回溯回去
        brain = history.reduce(CalculatorBrain.left("0")) { result, item in
            result.apply(item: item)
        }
    }
}
