//
//  CalculatorButtonItem.swift
//  objccn-swiftui
//
//  Created by kingcos on 2019/12/30.
//  Copyright © 2019 kingcos. All rights reserved.
//

import UIKit

enum CalculatorButtonItem {
    // 操作符
    enum Op: String {
        case plus = "+"
        case minus = "-"
        case divide = "÷"
        case multiply = "×"
        case equal = "="
    }
    
    // 特殊指令
    enum Command: String {
        case clear = "AC"
        case flip = "+/-"
        case percent = "%"
    }
    
    // 数字
    case digit(Int)
    // 小数点
    case dot
    // 操作符
    case op(Op)
    // 特殊指令
    case command(Command)
}

extension CalculatorButtonItem {
    // 按钮显示内容
    var title: String {
        switch self {
        case .digit(let value):
            return String(value)
        case .dot:
            return "."
        case .op(let op):
            return op.rawValue
        case .command(let command):
            return command.rawValue
        }
    }
    
    // 按钮大小
    var size: CGSize {
        CGSize(width: 88, height: 88)
    }
    
    // 背景颜色
    var backgroundColorName: String {
        switch self {
        case .digit, .dot:
            return "digitBackground"
        case .op:
            return "operatorBackground"
        case .command:
            return "commandBackground"
        }
    }
}


extension CalculatorButtonItem: Hashable {}
