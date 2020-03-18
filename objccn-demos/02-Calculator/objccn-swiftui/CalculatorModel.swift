//
//  CalculatorModel.swift
//  objccn-swiftui
//
//  Created by kingcos on 2020/1/14.
//  Copyright © 2020 kingcos. All rights reserved.
//

import Combine

// CalculatorModel 自身是 ObservableObject 可观察的对象（被观察者）
// ObservableObject 相比 @State 更自由一些
class CalculatorModel: ObservableObject {
    // 在数据将要发生改变时，这个属性用来向外进行广播，它的订阅者 (一般是 View 相关的逻辑) 在收到通知后，对 View 进行刷新
    // PassthroughSubject 提供 send 方法用来通知外界事件发生，即驱动 UI 的数据将要改变
    // 使用 @Published 时需注释 ⬇️
//    let objectWillChange = PassthroughSubject<Void, Never>()
    
//    var brain: CalculatorBrain = .left("0") {
//        // 手动在将要设置时调用 send
//        willSet {
//            objectWillChange.send()
//        }
//    }
    
    // 声明为 @Published 省略了 willSet 和 objectWillChange
    @Published var brain: CalculatorBrain = .left("0")
    
    @Published var history: [CalculatorButtonItem] = []
    
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
        brain = brain.apply(item: item)
        history.append(item) // 加入历史
        
        temporaryKept.removeAll()
        slidingIndex = Float(totalCount)
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
