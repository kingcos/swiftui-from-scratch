//
//  ContentView.swift
//  TCADemo
//
//  Created by 买明 on 2022/7/6.
//

import SwiftUI
import ComposableArchitecture

struct Counter: Equatable {
    var count: Int = 0
}

enum CounterAction {
    case increment
    case decrement
    
    case reset
    
    case setCount(String)
}

struct CounterEnvironment {
    
}

let counterReducer = Reducer<Counter, CounterAction, CounterEnvironment> { state, action, _ in
    switch action {
    case .increment:
        state.count += 1
        return .none
        
    case .decrement:
        state.count -= 1
        return .none
        
    case .reset:
        state.count = 0
        return .none
        
    case .setCount(let text):
//        if let value = Int(text) {
//            state.count = value
//        }
        state.countString = text
        return .none
    }
}
    .debug()

extension Counter {
    var countString: String {
        get { String(count) }
        set { count = Int(newValue) ?? count }
    }
}

struct ContentView: View {
    let store: Store<Counter, CounterAction>
    
    var body: some View {
        // WithViewStore 遵守 View 协议
        // extension WithViewStore: View where Content: View
        WithViewStore(store) { viewStore in
            VStack {
                HStack {
                    Button("-") { viewStore.send(.decrement) }
                    Text("\(viewStore.count)")
                        .monospacedDigit()
                        .foregroundColor(colorOfCount(viewStore.count))
                    Button("+") { viewStore.send(.increment) }
                }
                Button("RESET") {
                    viewStore.send(.reset)
                }
                
                TextField(String(viewStore.count),
                          text: viewStore.binding(
                            // 负责为 View 提供数据
//                            get: { String($0.count) },
                            // 简化：keyPath 作为函数，即 (Counter) -> String
                            get: \.countString,
                            // 将 View 新产生的值转换为 Action，并触发 Reducer
//                            send: { CounterAction.setCount($0) }
                            // 简化：enum case 可作为函数，即 (String) -> CounterAction
                            send: CounterAction.setCount
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(store: Store(initialState: Counter(),
                                 reducer: counterReducer,
                                 environment: CounterEnvironment()))
    }
}
