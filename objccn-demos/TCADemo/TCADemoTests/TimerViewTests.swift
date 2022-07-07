//
//  TimerViewTests.swift
//  TCADemoTests
//
//  Created by kingcos on 2022/7/7.
//

import XCTest
import ComposableArchitecture
@testable import TCADemo

class TimerViewTests: XCTestCase {
    // 该队列不同于主队列，其可手动控制时间
    let scheduler = DispatchQueue.test // TestSchedulerOf<DispatchQueue>

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTimerUpdate() throws {
        let store = TestStore(
            initialState: TimerState(),
            reducer: timerReducer,
            environment: TimerEnvironment(
                date: { Date(timeIntervalSince1970: 100) },
                mainQueue: scheduler.eraseToAnyScheduler()
            )
        )
    
        store.send(.start) {
            $0.started = Date(timeIntervalSince1970: 100)
        }
        scheduler.advance(by: .milliseconds(35)) // 调整时间到 35ms 后
        store.receive(.timeUpdated) { // 期望发生三次更新（35 / 10 = 3 次）
            $0.duration = 0.01
        }
        store.receive(.timeUpdated) {
            $0.duration = 0.02
        }
        store.receive(.timeUpdated) {
            $0.duration = 0.03
        }
        store.send(.stop)
    }
    
    func testSampleTextRequest() throws {
        let store = TestStore(
            initialState: SampleTextState(loading: false, text: ""),
            reducer: sampleTextReducer,
            environment: SampleTextEnvironment(loadText: { Effect(value: "kingcos.me") }, // 返回完成的副作用
//                                               mainQueue: scheduler.eraseToAnyScheduler())
                                               mainQueue: .immediate) // 无视掉 Effect (或者说 Publisher) 中的有关时间的部分，而立即让这些 Effect 完成
            // 但 .immediate 无法对应和测试像是 Debounce、Throttle 或者 Timer 这类行为。对于这种需要验证时间的行为，还是应该使用 TestScheduler。
        )
        store.send(.load) { state in
            state.loading = true
        }
        
        // 不使用 .advance 时，等同于 .zero，即不发生时间流逝（但会把所有当前“堆积”的 Effect 事件都发送出去）
//        scheduler.advance() // 使用 .immediate 时注释
        store.receive(.loaded(.success("kingcos.me"))) { state in
            state.loading = false
            state.text = "kingcos.me"
        }
        
        // 其他操作：
        // concatenate (顺次执行多个 Effect)
        // merge (同时执行多个 Effect) 
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
