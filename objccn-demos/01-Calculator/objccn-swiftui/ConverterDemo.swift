//
//  ConverterDemo.swift
//  objccn-swiftui
//
//  Created by kingcos on 2020/1/3.
//  Copyright © 2020 kingcos. All rights reserved.
//

import Foundation

// propertyWrapper：比如通过属性对 UserDefault 或者 Keychain 进行读写，对某个字符串进行格式化或者去前后段空白，为属性读写加锁等等
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
    @Converter(initialValue: "100", from: "USD", to: "CNY", rate: 6.88)
    var usd_cny

    @Converter(initialValue: "100", from: "CNY", to: "EUR", rate: 0.13)
    var cny_eur

    func foo() {
        // wrappedValue - projectedValue
        print("\(usd_cny) = \($usd_cny)")
        print("\(cny_eur) = \($cny_eur)")
    }
}
