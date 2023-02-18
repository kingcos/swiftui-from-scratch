//
//  SampleTextView.swift
//  TCADemo
//
//  Created by kingcos on 2022/7/7.
//

import SwiftUI
import Combine
import ComposableArchitecture

// Publishers.Map<URLSession.DataTaskPublisher, String>
let sampleRequest = URLSession
    .shared
    .dataTaskPublisher(for: URL(string: "https://kingcos.me")!)
    .map { element -> String in
        String(data: element.data, encoding: .utf8) ?? ""
    }

struct SampleTextEnvironment {
    var loadText: () -> Effect<String, URLError>
    var mainQueue: AnySchedulerOf<DispatchQueue>
    
    static let live = SampleTextEnvironment(loadText: {
        // eraseToEffect：将 Publisher 转换为 Effect
        sampleRequest.eraseToEffect()
    }, mainQueue: .main)
}

enum SampleTextAction: Equatable {
    case load // 加载（请求）
    case loaded(Result<String, URLError>) // 加载完成（响应）
}

struct SampleTextState: Equatable {
    var loading: Bool
    var text: String
}

let sampleTextReducer = Reducer<SampleTextState, SampleTextAction, SampleTextEnvironment> {
    state, action, environment in
    switch action {
    case .load:
        state.loading = true
    
    return environment
            .loadText()
            .receive(on: environment.mainQueue)
            .catchToEffect(SampleTextAction.loaded) // 转换类型：Effect<String, URLError> => Effect<SampleTextAction, Never>
//            .catchToEffect({ result in SampleTextAction.loaded(result) }) // 上一行等同于本行
        /*
         public func catchToEffect<T>(
           _ transform: @escaping (Result<Output, Failure>) -> T
         ) -> Effect<T, Never>
         */
    case .loaded(let result): // 处理 Effect 结果和更新状态
        state.loading = false
        do {
            state.text = try result.get()
        } catch {
            state.text = "Error: \(error)"
        }
        return .none
    }
}

struct SampleTextView: View {
    let store: Store<SampleTextState, SampleTextAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            ZStack {
                VStack {
                    Button("Load") { viewStore.send(.load) }
                    Text(viewStore.text)
                }
                if viewStore.loading {
                    ProgressView().progressViewStyle(.circular)
                }
            }
        }
    }
}

struct SampleTextView_Previews: PreviewProvider {
    static let store = Store(initialState: SampleTextState(loading: false, text: ""), reducer: sampleTextReducer, environment: .live)
    
    static var previews: some View {
        SampleTextView(store: store)
    }
}
