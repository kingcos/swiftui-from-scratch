//
//  HexagonParameters.swift
//  02-Drawing and Animation
//
//  Created by kingcos on 2020/2/4.
//  Copyright © 2020 kingcos. All rights reserved.
//

import CoreGraphics

// 六边形参数
struct HexagonParameters {
    struct Segment {
        // 定义段结构体，代表六边形每一边的 3 个点：
        let line: CGPoint    // 边的起点
        let curve: CGPoint   //
        let control: CGPoint // 控制曲线的形状
    }

    static let adjustment: CGFloat = 0.085

    static let segments = [
        Segment(
            line:    CGPoint(x: 0.60, y: 0.05),
            curve:   CGPoint(x: 0.40, y: 0.05),
            control: CGPoint(x: 0.50, y: 0.00)
        ),
        Segment(
            line:    CGPoint(x: 0.05, y: 0.20 + adjustment),
            curve:   CGPoint(x: 0.00, y: 0.30 + adjustment),
            control: CGPoint(x: 0.00, y: 0.25 + adjustment)
        ),
        Segment(
            line:    CGPoint(x: 0.00, y: 0.70 - adjustment),
            curve:   CGPoint(x: 0.05, y: 0.80 - adjustment),
            control: CGPoint(x: 0.00, y: 0.75 - adjustment)
        ),
        Segment(
            line:    CGPoint(x: 0.40, y: 0.95),
            curve:   CGPoint(x: 0.60, y: 0.95),
            control: CGPoint(x: 0.50, y: 1.00)
        ),
        Segment(
            line:    CGPoint(x: 0.95, y: 0.80 - adjustment),
            curve:   CGPoint(x: 1.00, y: 0.70 - adjustment),
            control: CGPoint(x: 1.00, y: 0.75 - adjustment)
        ),
        Segment(
            line:    CGPoint(x: 1.00, y: 0.30 + adjustment),
            curve:   CGPoint(x: 0.95, y: 0.20 + adjustment),
            control: CGPoint(x: 1.00, y: 0.25 + adjustment)
        )
    ]
    
//    struct Segment {
//        let useWidth: (CGFloat, CGFloat, CGFloat)
//        let xFactors: (CGFloat, CGFloat, CGFloat)
//        let useHeight: (CGFloat, CGFloat, CGFloat)
//        let yFactors: (CGFloat, CGFloat, CGFloat)
//    }
    
//    static let points = [
//        Segment(
//            useWidth:  (1.00, 1.00, 1.00),
//            xFactors:  (0.60, 0.40, 0.50),
//            useHeight: (1.00, 1.00, 0.00),
//            yFactors:  (0.05, 0.05, 0.00)
//        ),
//        Segment(
//            useWidth:  (1.00, 1.00, 0.00),
//            xFactors:  (0.05, 0.00, 0.00),
//            useHeight: (1.00, 1.00, 1.00),
//            yFactors:  (0.20 + adjustment, 0.30 + adjustment, 0.25 + adjustment)
//        ),
//        Segment(
//            useWidth:  (1.00, 1.00, 0.00),
//            xFactors:  (0.00, 0.05, 0.00),
//            useHeight: (1.00, 1.00, 1.00),
//            yFactors:  (0.70 - adjustment, 0.80 - adjustment, 0.75 - adjustment)
//        ),
//        Segment(
//            useWidth:  (1.00, 1.00, 1.00),
//            xFactors:  (0.40, 0.60, 0.50),
//            useHeight: (1.00, 1.00, 1.00),
//            yFactors:  (0.95, 0.95, 1.00)
//        ),
//        Segment(
//            useWidth:  (1.00, 1.00, 1.00),
//            xFactors:  (0.95, 1.00, 1.00),
//            useHeight: (1.00, 1.00, 1.00),
//            yFactors:  (0.80 - adjustment, 0.70 - adjustment, 0.75 - adjustment)
//        ),
//        Segment(
//            useWidth:  (1.00, 1.00, 1.00),
//            xFactors:  (1.00, 0.95, 1.00),
//            useHeight: (1.00, 1.00, 1.00),
//            yFactors:  (0.30 + adjustment, 0.20 + adjustment, 0.25 + adjustment)
//        )
//    ]
}
