//
//  AlignmentAdvancedView.swift
//  04-Layout
//
//  Created by kingcos on 2022/7/5.
//

import SwiftUI

extension VerticalAlignment {
    struct SelectAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[VerticalAlignment.center]
        }
    }
    
    static let select = VerticalAlignment(SelectAlignment.self)
}

struct AlignmentAdvancedView: View {
    @State var selectedIndex = 0
    
    let names = [
        "kingcos",
        "kingcos.me",
        "萌面大道"
    ]

    
    var body: some View {
        VStack {
            // 1
            HStack {
                Text("User:")
                    .font(.footnote)
                    .foregroundColor(.green)
                Image(systemName: "person.circle")
                    .foregroundColor(.green)
                VStack(alignment: .leading) {
                    ForEach(0..<names.count) { index in
                        Text(names[index])
                            .foregroundColor(self.selectedIndex == index ? .green : .primary)
                            .onTapGesture {
                                selectedIndex = index
                            }
                    }
                }
            }
            .border(.blue, width: 1)
            
            // 2
            HStack(alignment: .select) {
                Text("User:")
                    .font(.footnote)
                    .foregroundColor(.green)
                    .alignmentGuide(.select) { d in
                        // User 的 bottom - 常数 == 整体的 center
                        // 常数 > 0，整体 center 不变时，User 向上偏移
                        // 本例中，User 固定在
                        d[.bottom] + CGFloat(selectedIndex) * 20.3
                    }
                    .border(.blue, width: 1)
                Image(systemName: "person.circle")
                    .foregroundColor(.green)
                    .alignmentGuide(.select) { d in
                        d[VerticalAlignment.center]
                    }
                    .border(.blue, width: 1)
                VStack(alignment: .leading) {
                    ForEach(0..<names.count) { index in
                        Text(names[index])
                            .foregroundColor(selectedIndex == index ? .green : .primary)
                            .onTapGesture {
                                selectedIndex = index
                            }
                            .border(.blue, width: 1)
                            .alignmentGuide(self.selectedIndex == index ? .select : .center) { d in
                                if selectedIndex == index {
                                    // 将选中行设置为 VStack 的对齐位置
                                    return d[VerticalAlignment.center]
                                } else {
                                    return 0
                                }
                            }
                    }
                }
            }
            .border(.blue, width: 1)
            
            
            HStack {
              Image(systemName: "person.circle")
                    .border(.blue, width: 1)
              Text("User:")
                    .border(.blue, width: 1)
              Text("kingcos | kingcos.me")
                    .border(.blue, width: 1)
            }
            .lineLimit(1)
            .frame(width: 200)
            .border(.blue, width: 1)

        }
    }
}

struct AlignmentAdvancedView_Previews: PreviewProvider {
    static var previews: some View {
        AlignmentAdvancedView()
    }
}
