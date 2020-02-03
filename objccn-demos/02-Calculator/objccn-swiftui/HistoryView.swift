//
//  HistoryView.swift
//  objccn-swiftui
//
//  Created by kingcos on 2020/1/15.
//  Copyright © 2020 kingcos. All rights reserved.
//

import SwiftUI
import Combine

struct HistoryView: View {
    @ObservedObject var model: CalculatorModel
    
    // https://developer.apple.com/documentation/swiftui/viewbuilder
    var body: some View {
        VStack {
            if model.totalCount == 0 {
                Text("没有履历")
            } else {
                HStack {
                    Text("履历").font(.headline)
                    Text("\(model.historyDetail)").lineLimit(nil)
                }
                HStack {
                    Text("显示").font(.headline)
                    Text("\(model.brain.output)")
                }
                Slider(
                    value: $model.slidingIndex,
                    in: 0...Float(model.totalCount),
                    step: 1
                )
            }
        }.padding()
    }
}
