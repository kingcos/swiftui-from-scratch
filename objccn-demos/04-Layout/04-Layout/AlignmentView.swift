//
//  AlignmentView.swift
//  04-Layout
//
//  Created by kingcos on 2022/7/5.
//

import SwiftUI

extension VerticalAlignment {
    struct MyCenter: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            // 对齐的位置为高度的一半
            // 水平分布时，即中线对齐，与默认一致
            context.height / 2
        }
    }
    
    static let myCenter = VerticalAlignment(MyCenter.self)
}

struct AlignmentView: View {
    var body: some View {
        VStack {
            // 1
            HStack {
                Image(systemName: "person.circle")
                    .background(Color.yellow)
                Text("User:")
                    .background(Color.red)
                Text("kingcos | kingcos.me")
                    .background(Color.green)
            }
            .lineLimit(1)
            .background(Color.purple)
            .border(.blue, width: 1)

            // 2
            HStack(alignment: .myCenter) {
                Image(systemName: "person.circle")
                    .background(Color.yellow)
                Text("User:")
                    .background(Color.red)
                Text("kingcos | kingcos.me")
                    .background(Color.green)
            }
            .lineLimit(1)
            .background(Color.purple)
            .border(.blue, width: 1)
            
            // 3
            // 将默认布局写出如下：
            HStack(alignment: .center) { // 默认中心
                Image(systemName: "person.circle")
                    .alignmentGuide(VerticalAlignment.center, // 默认中心
                                    computeValue: { d in
                        d[VerticalAlignment.center]
                    })
                    .background(Color.yellow)
                Text("User:")
                    .alignmentGuide(VerticalAlignment.center,
                                    computeValue: { d in
                        d[VerticalAlignment.center]
                    })
                    .background(Color.red)
                Text("kingcos | kingcos.me")
                    .alignmentGuide(VerticalAlignment.center,
                                    computeValue: { d in
                        d[VerticalAlignment.center]
                    })
                    .background(Color.green)
            }
            .lineLimit(1)
            .background(Color.purple)
            .border(.blue, width: 1)

            // 4
            HStack(alignment: .center) { // 默认中心
                Image(systemName: "person.circle")
                    .alignmentGuide(VerticalAlignment.center, // 默认中心
                                    computeValue: { d in
                        d[VerticalAlignment.center]
                    })
                    .background(Color.yellow)
                Text("User:")
                    .alignmentGuide(VerticalAlignment.center,
                                    computeValue: { d in
                        d[VerticalAlignment.bottom] // 文本底边对齐，其他均为中心，因此该 Text 和其他的中线对齐
                    })
                    .background(Color.red)
                Text("kingcos | kingcos.me")
                    .alignmentGuide(VerticalAlignment.center,
                                    computeValue: { d in
                        d[VerticalAlignment.center]
                    })
                    .background(Color.green)
            }
            .lineLimit(1)
            .background(Color.purple)
            .border(.blue, width: 1)
            
            // 5
            HStack(alignment: .center) { // 默认中心
                Image(systemName: "person.circle")
                    .alignmentGuide(.leading, // 无效
                                    computeValue: { _ in 10 })
                    .background(Color.yellow)
                Text("User:")
                    .alignmentGuide(VerticalAlignment.center) { d in
                        d[.bottom] + (d[explicit: .leading] ?? 0) // .center 时为 nil，因此这里无意义；文本底边 + 一个高度 == 其他中心；更适用于 ZStack
                    }
                    .background(Color.red)
                Text("kingcos | kingcos.me")
                    .background(Color.green)
            }
            .lineLimit(1)
            .background(Color.purple)
            .border(.blue, width: 1)
            
        }
        
//        VStack {
//            Text("Today's Weather")
//                .font(.title)
//                .border(.gray)
//            HStack {
//                Text("🌧")
//                Text("Rain & Thunderstorms")
//                Text("⛈")
//            }
//            .alignmentGuide(HorizontalAlignment.center) { _ in  50 }
//            .border(.gray)
//        }
//        .border(.blue)
    }
}

struct AlignmentView_Previews: PreviewProvider {
    static var previews: some View {
        AlignmentView()
    }
}
