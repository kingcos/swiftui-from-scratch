//
//  GameView.swift
//  TCADemo
//
//  Created by kingcos on 2022/7/8.
//

import SwiftUI
import ComposableArchitecture

struct GameState: Equatable {
    // 组合 State
    var counter: Counter = .init()
    var timer: TimerState = .init()
}

enum GameAction {
    // 组合 Action
    case counter(CounterAction)
    case timer(TimerAction)
}

// 融合 Environment
struct GameEnvironment {
  var generateRandom: (ClosedRange<Int>) -> Int
  var uuid: () -> UUID
  var date: () -> Date
  var mainQueue: AnySchedulerOf<DispatchQueue>
  
  static let live = GameEnvironment(
    generateRandom: Int.random,
    uuid: UUID.init,
    date: Date.init,
    mainQueue: .main
  )
}

// pullback 将子组件 reducer 转换为父组件 reducer 类型
/*
 public func pullback<GlobalState, GlobalAction, GlobalEnvironment>(
   state toLocalState: WritableKeyPath<GlobalState, State>,
   action toLocalAction: CasePath<GlobalAction, Action>,
   environment toLocalEnvironment: @escaping (GlobalEnvironment) -> Environment
 ) -> Reducer<GlobalState, GlobalAction, GlobalEnvironment>
 */
// combine 将转换结果合并
let gameReducer = Reducer<GameState,
                          GameAction,
                          GameEnvironment>
    .combine(counterReducer.pullback( // 将子组件 reducer 拉回作为父组件的一部分
        state: \.counter,
        action: /GameAction.counter, // 转换为 CasePath struct；负责从父组件 Action 将子组件 Action 提取出
//        environment: { _ in .live }),
        environment: { .init(generateRandom: $0.generateRandom, generateUUID: $0.uuid) }),
     timerReducer.pullback(
         state: \.timer,
         action: /GameAction.timer,
//         environment: { _ in .live }
         environment: { .init(date: $0.date, mainQueue: $0.mainQueue) }
       )
    )

// ---


struct GameView: View {
    let store: Store<GameState, GameAction>
    
    var body: some View {
        // stateless：GameView 本身不依赖 state，因此不需要订阅 store 的变更，避免无意义的刷新
        // 相当于用用 Void 对原来的 store 进行切分：store.scope(state: { _ in () })
        WithViewStore(store.stateless) { viewStore in
              VStack {
                  // 切分 store
                  // 子 Action => 父 Action => 父 reducer => 子 reducer（CasePath）
                  TimerView(store: store.scope(state: \.timer, action: GameAction.timer))
                  ContentView(store: store.scope(state: \.counter, action: GameAction.counter))
              }.onAppear {
                  viewStore.send(.timer(.start))
              }
        }
    }
    
    var body2: some View {
        VStack {
            TimerView(store: store.scope(state: \.timer, action: GameAction.timer))
            ContentView(store: store.scope(state: \.counter, action: GameAction.counter))
            
            WithViewStore(store) { viewStore in
                Color
                    .clear
                    .frame(width: 0, height: 0)
                    .onAppear {
                      viewStore.send(.timer(.start))
                  }
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(store: Store(initialState: GameState(),
                              reducer: gameReducer,
                              environment: .live))
    }
}
