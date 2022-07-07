//
//  MultiBindingsView.swift
//  TCADemo
//
//  Created by kingcos on 2022/7/7.
//

import SwiftUI
import ComposableArchitecture

struct MyState: Equatable {
    @BindableState var foo: Bool = false
    @BindableState var bar: String = ""
}

/*
 原理：
 
 /// An action type that exposes a `binding` case that holds a ``BindingAction``.
 ///
 /// Used in conjunction with ``BindableState`` to safely eliminate the boilerplate typically
 /// associated with mutating multiple fields in state.
 ///
 /// See the documentation for ``BindableState`` for more details.
 public protocol BindableAction {
   /// The root state type that contains bindable fields.
   associatedtype State

   /// Embeds a binding action in this action type.
   ///
   /// - Returns: A binding action.
   static func binding(_ action: BindingAction<State>) -> Self
 }
 */
enum MyAnotherAction: BindableAction {
    // BindingAction<State> -> Self 要求一个签名为 BindingAction<State> -> Self
    // 且名为 binding 的函数，利用了 Swift 5.3 的 enum case 可作为函数的新特性
    case binding(BindingAction<MyState>)
}

struct MyEnvironment {
    
}

let myReducer = Reducer<MyState, MyAnotherAction, MyEnvironment> { state, action, _ in
    switch action {
    case .binding:
        return .none
    }
}
    .binding()
    .debug()

struct MultiBindingsView: View {
    let store: Store<MyState, MyAnotherAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                // 即使有多个绑定值，也都可以使用类似 SwiftUI 本身的做法，即 $
                Toggle("Toggle!", isOn: viewStore.binding(\.$foo))
                TextField("Text Field!", text: viewStore.binding(\.$bar))
            }
        }
    }
}

struct MultiBindingsView_Previews: PreviewProvider {
    static var previews: some View {
        MultiBindingsView(store: Store(
            initialState: MyState(),
            reducer: myReducer,
            environment: MyEnvironment())
        )
    }
}
