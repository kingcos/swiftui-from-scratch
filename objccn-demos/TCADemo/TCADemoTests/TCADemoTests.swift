//
//  TCADemoTests.swift
//  TCADemoTests
//
//  Created by kingcos on 2022/7/6.
//

import XCTest
import ComposableArchitecture
@testable import TCADemo

class TCADemoTests: XCTestCase {
    
    var store: TestStore<Counter, Counter, CounterAction, CounterAction, CounterEnvironment>!
    var testStore: TestStore<Counter, Counter, CounterAction, CounterAction, CounterEnvironment>!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        store = TestStore(
            initialState: Counter(count: Int.random(in: -100...100)),
            reducer: counterReducer,
            environment: .live // CounterEnvironment()
        )
        
        testStore = TestStore(
            initialState: Counter(count: Int.random(in: -100...100)),
            reducer: counterReducer,
            environment: .test // CounterEnvironment()
        )
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testCounterIncrement() throws {
        store.send(.increment) { state in
            state.count += 1
        }
    }
    
    func testCounterDecrement() throws {
        store.send(.decrement) { state in
            state.count -= 1
        }
    }
    
    func testCounterReset() throws {
        /*
         // 初始为 16，-19 => playNext => 0，5
         CounterAction.playNext
         Counter(
       -   count: 16,
       +   count: 0,
       -   secret: -19
       +   secret: 5
         )
         */
//        store.send(.reset) { state in
//            state.count = 0
//        }
        testStore.send(.playNext) { state in
//            state.count = 0
//            state = Counter(count: 0, secret: 5, id: UUID.init(uuidString: "7D0E1EA1-4FDF-4769-B6CC-0931BB03087B")!)
            state = Counter(count: 0, secret: 5, id: .dummy)
        }
    }

    func testSlider() {
        testStore.send(.setSliderCount(20.5)) { state in
            state.sliderCount = 20
        }
    }
    
    func testSetCount() {
        testStore.send(.setCount("50")) { state in
            state.count = 50
        }
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

extension CounterEnvironment {
    static let test = CounterEnvironment(generateRandom: { _ in 5 }, generateUUID: { .dummy })
//                                         generateUUID: { UUID.init(uuidString: "7D0E1EA1-4FDF-4769-B6CC-0931BB03087B")! })
                                         
}

extension UUID {
    static let dummy = UUID.init(uuidString: "7D0E1EA1-4FDF-4769-B6CC-0931BB03087B")!
}
