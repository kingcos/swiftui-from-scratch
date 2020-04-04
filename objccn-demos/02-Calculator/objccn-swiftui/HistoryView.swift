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
    
    // https://www.hackingwithswift.com/quick-start/swiftui/how-to-make-a-view-dismiss-itself
//    @Environment(\.presentationMode) var presentationMode
    
    @Binding var isPresented: Bool
    
    // https://developer.apple.com/documentation/swiftui/viewbuilder
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button("Close") {
//                        self.presentationMode.wrappedValue.dismiss()
                        
                        self.isPresented = false
                    }
                    .padding()
                    Spacer()
                }
                Spacer()
            }
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
}
