//
//  ContentView.swift
//  TCADemo
//
//  Created by kingcos on 2022/7/6.
//

import SwiftUI
import ComposableArchitecture

struct Counter: Equatable, Identifiable {
    var count: Int = 0
    var secret = Int.random(in: -100...100)
    
    var id = UUID()
}

extension Counter {
    enum CheckResult {
        case lower, equal, higher
    }
    
    var checkResult: CheckResult {
        if count < secret { return .lower }
        if count > secret { return .higher }
        
        return .equal
    }
    
    var sliderCount: Float {
        get { Float(count) }
        set { count = Int(newValue) }
    }
}

enum CounterAction {
    case increment
    case decrement
    
//    case reset
    case playNext
    
    case setCount(String)
    case setSliderCount(Float)
}

// Environment：为了应对外部依赖（比如 playNext 的随机数）；通过提供依赖解决了 reducer 输入阶段的副作用
struct CounterEnvironment {
    var generateRandom: (ClosedRange<Int>) -> Int
    var generateUUID: () -> UUID
    
    static let live = CounterEnvironment(generateRandom: Int.random, generateUUID: UUID.init)
}

let counterReducer = Reducer<Counter,
                             CounterAction,
                             CounterEnvironment> { state, action, env in
    switch action {
    case .increment:
        state.count += 1
        return .none // 无副作用（输出）
        
    case .decrement:
        state.count -= 1
        return .none
        
//    case .reset:
//        state.count = 0
//        return .none
        
    case .playNext:
        state.id = env.generateUUID() // UUID()
        
        state.count = 0
//        state.secret = Int.random(in: -100...100)
        state.secret = env.generateRandom(-100...100)
        return .none
        
    case .setCount(let text):
        if let value = Int(text) {
            state.count = value
        }
        return .none
        
    case .setSliderCount(let count):
        state.sliderCount = count
        return .none
    }
}
    .debug()

struct ContentView: View {
    let store: Store<Counter, CounterAction>
    
    var body: some View {
        // WithViewStore 遵守 View 协议
        // extension WithViewStore: View where Content: View
        WithViewStore(store) { viewStore in
            VStack {
                checkLabel(with: viewStore.checkResult)
                
                HStack {
                    Button("-") { viewStore.send(.decrement) }
                    Text("\(viewStore.count)")
                        .monospacedDigit()
                        .foregroundColor(colorOfCount(viewStore.count))
                    Button("+") { viewStore.send(.increment) }
                }
                
//                Button("RESET") {
//                    viewStore.send(.reset)
//                }
                
//                Slider(value: viewStore.binding(get: { Float($0.count) }, send: { CounterAction.setCount("\(Int($0))") }), in: -100...100)
                Slider(value: viewStore.binding(get: \.sliderCount, send: CounterAction.setSliderCount), in: -100...100)
                
                Button("NEXT") {
                    viewStore.send(.playNext)
                }
                
                TextField(String(viewStore.count),
                          text: viewStore.binding(
                            // 负责为 View 提供数据
                            get: { String($0.count) },
                            // 将 View 新产生的值转换为 Action，并触发 Reducer
                            send: { CounterAction.setCount($0) }
                ))
                .monospacedDigit()
                .frame(width: 100)
                .multilineTextAlignment(.center)
                .foregroundColor(colorOfCount(viewStore.count))
            }
        }
    }
    
    func colorOfCount(_ value: Int) -> Color? {
        if value == 0 { return nil }
        return value < 0 ? .red : .green
    }
    
    func checkLabel(with checkResult: Counter.CheckResult) -> some View {
        switch checkResult {
        case .lower:
          return Label("Lower", systemImage: "lessthan.circle")
            .foregroundColor(.red)
        case .higher:
          return Label("Higher", systemImage: "greaterthan.circle")
            .foregroundColor(.red)
        case .equal:
          return Label("Correct", systemImage: "checkmark.circle")
            .foregroundColor(.green)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(store: Store(initialState: Counter(),
                                 reducer: counterReducer,
//                                 environment: CounterEnvironment(generateRandom: { Int.random(in: $0) })
                                 environment: .live
                                ))
    }
}
