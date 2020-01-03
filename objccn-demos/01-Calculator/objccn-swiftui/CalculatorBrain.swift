//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by 王 巍 on 2019/07/19.
//  Copyright © 2019 OneV's Den. All rights reserved.
//

import Foundation

// Redux (状态管理和组件通讯架构)
// 1. 将 app 当作一个状态机，状态决定用户界面。
// 2. 这些状态都保存在一个 Store 对象中，被称为 State。
// 3. View 不能直接操作 State，而只能通过发送 Action 的方式，间接改变存储在 Store 中的 State。
// 4. Reducer 接受原有的 State 和发送过来的 Action，生成新的 State。
// 5. 用新的 State 替换 Store 中原有的状态，并用新状态来驱动更新界面。
 
typealias CalculatorState = CalculatorBrain
typealias CalculatorStateAction = CalculatorButtonItem

struct Reducer {
    // 纯函数指的是，返回值只由调用时的参数决定，而不依赖于任何系统状态，也不改变其作用域之外的变量状态的函数。
    static func reduce(
        state: CalculatorState,
        action: CalculatorStateAction
    ) -> CalculatorState {
        return state.apply(item: action)
    }
}

enum CalculatorBrain {
    // 输入算式左侧
    case left(String)
    // 输入算式左侧数字与操作符
    case leftOp(left: String, op: CalculatorButtonItem.Op)
    // 输入算式左侧数字、操作符、与右侧数字
    case leftOpRight(left: String, op: CalculatorButtonItem.Op, right: String)
    // 异常情况
    case error

    @discardableResult
    func apply(item: CalculatorButtonItem) -> CalculatorBrain {
        switch item {
        case .digit(let num):
            // 处理数字
            return apply(num: num)
        case .dot:
            // 处理小数点
            return applyDot()
        case .op(let op):
            // 处理操作符
            return apply(op: op)
        case .command(let command):
            // 处理独立命令
            return apply(command: command)
        }
    }

    // 显示输出
    var output: String {
        let result: String
        switch self {
        case .left(let left): result = left
        case .leftOp(let left, _): result = left
        case .leftOpRight(_, _, let right): result = right
        case .error: return "Error"
        }
        guard let value = Double(result) else {
            return "Error"
        }
        return formatter.string(from: value as NSNumber)!
    }

    private func apply(num: Int) -> CalculatorBrain {
        switch self {
        case .left(let left):
            return .left(left.apply(num: num))
        case .leftOp(let left, let op):
            return .leftOpRight(left: left, op: op, right: "0".apply(num: num))
        case .leftOpRight(let left, let op, let right):
            return .leftOpRight(left: left, op: op, right: right.apply(num: num))
        case .error:
            return .left("0".apply(num: num))
        }
    }

    private func applyDot() -> CalculatorBrain {
        switch self {
        case .left(let left):
            return .left(left.applyDot())
        case .leftOp(let left, let op):
            return .leftOpRight(left: left, op: op, right: "0".applyDot())
        case .leftOpRight(let left, let op, let right):
            return .leftOpRight(left: left, op: op, right: right.applyDot())
        case .error:
            return .left("0".applyDot())
        }
    }

    private func apply(op: CalculatorButtonItem.Op) -> CalculatorBrain {
        switch self {
        case .left(let left):
            switch op {
            case .plus, .minus, .multiply, .divide:
                return .leftOp(left: left, op: op)
            case .equal:
                return self
            }
        case .leftOp(let left, let currentOp):
            switch op {
            case .plus, .minus, .multiply, .divide:
                return .leftOp(left: left, op: op)
            case .equal:
                if let result = currentOp.calculate(l: left, r: left) {
                    return .leftOp(left: result, op: currentOp)
                } else {
                    return .error
                }
            }
        case .leftOpRight(let left, let currentOp, let right):
            switch op {
            case .plus, .minus, .multiply, .divide:
                if let result = currentOp.calculate(l: left, r: right) {
                    return .leftOp(left: result, op: op)
                } else {
                    return .error
                }
            case .equal:
                if let result = currentOp.calculate(l: left, r: right) {
                    return .left(result)
                } else {
                    return .error
                }
            }
        case .error:
            return self
        }
    }

    private func apply(command: CalculatorButtonItem.Command) -> CalculatorBrain {
        switch command {
        case .clear:
            return .left("0")
        case .flip:
            switch self {
            case .left(let left):
                return .left(left.flipped())
            case .leftOp(let left, let op):
                return .leftOpRight(left: left, op: op, right: "-0")
            case .leftOpRight(left: let left, let op, let right):
                return .leftOpRight(left: left, op: op, right: right.flipped())
            case .error:
                return .left("-0")
            }
        case .percent:
            switch self {
            case .left(let left):
                return .left(left.percentaged())
            case .leftOp:
                return self
            case .leftOpRight(left: let left, let op, let right):
                return .leftOpRight(left: left, op: op, right: right.percentaged())
            case .error:
                return .left("-0")
            }
        }
    }
}

// 格式化
var formatter: NumberFormatter = {
    let f = NumberFormatter()
    f.minimumFractionDigits = 0
    f.maximumFractionDigits = 8
    f.numberStyle = .decimal
    return f
}()

// String 扩展：一些常用操作
extension String {
    // 包含小数点
    var containsDot: Bool {
        return contains(".")
    }

    // 负数
    var startWithNegative: Bool {
        return starts(with: "-")
    }

    // 拼接数字字符串与数字 eg: "5".apply(num: 9) == "59"; "0".apply(num: 9) == "9"
    func apply(num: Int) -> String {
        return self == "0" ? "\(num)" : "\(self)\(num)"
    }

    // 拼接小数点
    func applyDot() -> String {
        return containsDot ? self : "\(self)."
    }

    // 取负
    func flipped() -> String {
        if startWithNegative {
            var s = self
            s.removeFirst()
            return s
        } else {
            return "-\(self)"
        }
    }

    // 取百分比
    func percentaged() -> String {
        return String(Double(self)! / 100)
    }
}

extension CalculatorButtonItem.Op {
    func calculate(l: String, r: String) -> String? {

        guard let left = Double(l), let right = Double(r) else {
            return nil
        }

        let result: Double?
        switch self {
        case .plus: result = left + right
        case .minus: result = left - right
        case .multiply: result = left * right
        case .divide: result = right == 0 ? nil : left / right
        case .equal: fatalError()
        }
        return result.map { String($0) }
    }
}
