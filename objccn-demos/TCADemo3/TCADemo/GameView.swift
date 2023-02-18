//
//  GameView.swift
//  TCADemo
//
//  Created by kingcos on 2022/7/8.
//

import SwiftUI
import ComposableArchitecture

let resultListStateTag = UUID()

struct GameState: Equatable {
    // 组合 State
    var counter: Counter = .init()
    var timer: TimerState = .init()
    
//    var results: [GameResult] = []
    // IdentifiedArrayOf 类似 Array，有顺序，O(1) 按下标取元素；不同在于元素需要遵守 Identifiable，也可支持按 id 快速查找
    // Array 的问题：根据判等查找过慢；异步操作可能有异常
    var results = IdentifiedArrayOf<GameResult>()
    var lastTimestamp = 0.0
    
    // TCA 中将一个任意值转为 Hashable 更简单的方式就是用 Identified 包装它，手动为它赋予一个 id 值，用它作为 V 的类型
    var resultListState: Identified<UUID, GameResultListState>?
}

enum GameAction {
    // 组合 Action
    case counter(CounterAction)
    case timer(TimerAction)
    case listResult(GameResultListAction)
    
    case setNavigation(UUID?)
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
    .combine(
        .init { state, action, env in
            switch action {
            case .counter(.playNext):
              let result = GameResult(
//                secret: state.counter.secret,
//                guess: state.counter.count,
                counter: state.counter,
                timeSpent: state.timer.duration - state.lastTimestamp)
              state.results.append(result)
              state.lastTimestamp = state.timer.duration
              return .none
                
            case .setNavigation(.some(let id)):
                state.resultListState = .init(state.results, id: id)
                return .none
                
            case .setNavigation(.none):
                state.results = state.resultListState?.value ?? []
                state.resultListState = nil
                return .none
            default:
              return .none
            }
        },
        
        counterReducer.pullback( // 将子组件 reducer 拉回作为父组件的一部分
        state: \.counter,
        action: /GameAction.counter, // 转换为 CasePath struct；负责从父组件 Action 将子组件 Action 提取出
//        environment: { _ in .live }),
        environment: { .init(generateRandom: $0.generateRandom, generateUUID: $0.uuid) }),
     timerReducer.pullback(
         state: \.timer,
         action: /GameAction.timer,
//         environment: { _ in .live }
         environment: { .init(date: $0.date, mainQueue: $0.mainQueue) }
       ),
//        gameResultListReducer.pullback(
//            state: \.results,
//            action: /GameAction.listResult,
//            environment: { _ in .init() }
//        ),
        gameResultListReducer.pullback(
            state: \Identified.value,
            action: .self,
            environment: { $0 }
        )
        .optional()
        .pullback(state: \.resultListState, action: /GameAction.listResult, environment: { _ in .init() })
    )

struct GameResult: Equatable, Identifiable {
//  let secret: Int
//  let guess: Int
    let counter: Counter
    let timeSpent: TimeInterval
    
//  var correct: Bool { secret == guess }
    var correct: Bool { counter.secret == counter.count }
    
    var id: UUID { counter.id }
}

// ---

struct GameView: View {
    let store: Store<GameState, GameAction>
    
    var body: some View {
        // stateless：GameView 本身不依赖 state，因此不需要订阅 store 的变更，避免无意义的刷新
        // 相当于用 Void 对原来的 store 进行切分：store.scope(state: { _ in () })
        WithViewStore(store.scope(state: \.results)) { viewStore in
              VStack {
                  resultLabel(viewStore.state.elements)
                  Divider()
                  
                  // 切分 store
                  // 子 Action => 父 Action => 父 reducer => 子 reducer（CasePath）
                  TimerView(store: store.scope(state: \.timer, action: GameAction.timer))
                  ContentView(store: store.scope(state: \.counter, action: GameAction.counter))
              }.onAppear {
                  viewStore.send(.timer(.start))
              }
              .toolbar {
                  ToolbarItem(placement: .navigationBarTrailing) {
//                      NavigationLink("Detail") {
//                          GameResultListView(store: store.scope(state: \.results,
//                                                                action: GameAction.listResult))
//                      }
                      
                      WithViewStore(store) { viewStore in
                          NavigationLink("Detail",
                                         tag: resultListStateTag,
                                         selection: viewStore.binding(get: \.resultListState?.id,
                                                                      send:GameAction.setNavigation)) {
//                              Text("Sample")
                              IfLetStore(store.scope(state: \.resultListState?.value, action: GameAction.listResult),
                                         then: { GameResultListView(store: $0) })
                          }
                      }
                  }
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
    
    func resultLabel(_ results: [GameResult]) -> some View {
      Text("Result: \(results.filter(\.correct).count)/\(results.count) correct")
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(store: Store(initialState: GameState(),
                              reducer: gameReducer,
                              environment: .live))
    }
}
