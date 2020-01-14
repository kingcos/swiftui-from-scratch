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
    let objectWillChange = PassthroughSubject<Void, Never>()
    
//    var brain: CalculatorBrain = .left("0") {
//        // 手动在将要设置时调用 send
//        willSet {
//            objectWillChange.send()
//        }
//    }
    
    // 声明为 @Published 省略了 willSet
    @Published var brain: CalculatorBrain = .left("0")
    
    @Published var history: [CalculatorButtonItem] = []
    
    func apply(_ item: CalculatorButtonItem) {
        brain = brain.apply(item: item)
        history.append(item)
    }
}
