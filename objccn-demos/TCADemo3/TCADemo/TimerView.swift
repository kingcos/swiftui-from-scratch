//
//  TimerView.swift
//  TCADemo
//
//  Created by kingcos on 2022/7/7.
//

import SwiftUI
import ComposableArchitecture

struct TimerState: Equatable {
    var started: Date? = nil       // 开始时间
    var duration: TimeInterval = 0 // 已经经过的时间
}

// 行为
enum TimerAction {
  case start       // 开始计时
  case stop        // 停止计时
  case timeUpdated // 时间更新（Action => Reducer => State）
}

struct TimerEnvironment {
    // 使用环境值注入外部输入
    var date: () -> Date
    var mainQueue: AnySchedulerOf<DispatchQueue>
    
    static var live: TimerEnvironment {
        .init(date: Date.init, mainQueue: .main)
    }
}

let timerReducer = Reducer<TimerState, TimerAction, TimerEnvironment> {
    state, action, env in
    
    struct TimerId: Hashable {}
    
    switch action {
    case .start:
        if state.started == nil {
            state.started = env.date()
        }
        
        // Effect：解决 reducer 输出阶段的副作用
        // Effect.timer: TCA 内置的副作用：
        return Effect.timer(id: TimerId(), // 可通过 Id 取消；每次创建前也会调用 .cancel 取消对应 Id
                            every: .milliseconds(10),
                            tolerance: .zero,
                            on: env.mainQueue) // Effect<DispatchQueue.SchedulerTimeType, Never> 转换为 Effect<Action, Never>
        .map { time -> TimerAction in TimerAction.timeUpdated }
    
    case .timeUpdated:
        state.duration += 0.01
        return .none
        
    case .stop:
        return .cancel(id: TimerId()) // 传入 Hash 值相同的 Id 以取消
    }
}

struct TimerView: View {
    let store: Store<TimerState, TimerAction>
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack(alignment: .leading) {
                Label(viewStore.started == nil ? "-" : "\(viewStore.started!.formatted(date: .omitted, time: .standard))",
                      systemImage: "clock")
                    .monospacedDigit()
                Label("\(viewStore.duration, format: .number)s", systemImage: "timer")
                    .monospacedDigit()
            }
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static let store = Store(initialState: .init(), reducer: timerReducer, environment: .live)
    
    static var previews: some View {
        VStack {
            WithViewStore(store) { viewStore in
                VStack {
                    TimerView(store: store)
                    HStack {
                        Button("Start") { viewStore.send(.start) }
                        Button("Stop") { viewStore.send(.stop) }
                    }
                    .padding()
                }
            }
        }
    }
}
