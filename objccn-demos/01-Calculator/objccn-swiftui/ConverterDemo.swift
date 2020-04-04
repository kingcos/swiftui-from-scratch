//
//  ConverterDemo.swift
//  objccn-swiftui
//
//  Created by kingcos on 2020/1/3.
//  Copyright © 2020 kingcos. All rights reserved.
//

import Foundation

@propertyWrapper
public struct Percentage {
    var value: Int

    public var wrappedValue: Int {
        get { value }
        set { value = max(0, min(100, newValue)) }
    }

    public init(wrappedValue: Int) {
        value = wrappedValue
    }

    public init(initialValue: Int) {
        value = initialValue
    }
}

struct ViewModel {
    // init(initialValue: Int)
    @Percentage(initialValue: 1000) var progress1
    // public init(wrappedValue: Int)
    @Percentage var progress2 = 2000
}

@propertyWrapper struct Converter {
    let from: String
    let to: String
    let rate: Double
    
    var value: Double
    
    var wrappedValue: String {
        get { "\(from) \(value)" }
        set { value = Double(newValue) ?? -1 }
    }
    
    var projectedValue: String {
        return "\(to) \(value * rate)"
    }
    
    init(
        initialValue: String,
        from: String,
        to: String,
        rate: Double
    ) {
        self.rate = rate
        self.value = 0
        self.from = from
        self.to = to
        self.wrappedValue = initialValue
    }
}

struct Foo {
    @Converter(initialValue: "100", from: "USD", to: "CNY", rate: 6.88) // 构造方法
    var usd_cny // wrappedValue

    @Converter(initialValue: "100", from: "CNY", to: "EUR", rate: 0.13)
    var cny_eur

    func foo() {
        // wrappedValue - $projectedValue
        print("\(usd_cny) = \($usd_cny)")
        print("\(cny_eur) = \($cny_eur)")
        
        let vm = ViewModel()
        print(vm.progress1, vm.progress2)
    }
}

//USD 100.0 = CNY 688.0
//CNY 100.0 = EUR 13.0
//1000 2000
