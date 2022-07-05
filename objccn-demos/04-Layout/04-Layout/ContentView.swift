//
//  ContentView.swift
//  04-Layout
//
//  Created by kingcos on 2022/7/5.
//

import SwiftUI

// 布局原则：协商解决，层层上报
// 父层级的 View 根据某种规则，向子 View “提议” 一个可行的尺寸
// 子 View 以这个尺寸为参考，按照自己的需求进行布局；
// 在子 View 确定自己的尺寸后，它将这个需要的尺寸汇报回父 View，
// 父 View 最后把这个确定好尺寸的子 View 放置在座标系合适的位置上。
struct ContentView: View {
    var body: some View {
        VStack {
            // 1
            HStack { // 扣除默认 spacing，均分为 3 份
                // 根据内容决定自身宽度，并汇报 HStask；
                // HStack 将总宽度减去 Image 宽度，均分为 2 份
                // 即布局系统从左到右顺序处理
                Image(systemName: "person.circle")
                Text("User:")
                Text("kingcos | kingcos.me")
            }
            .lineLimit(1)
            .border(.blue, width: 1)
            
            Spacer()
            
            // 2
            HStack {
                // 左侧有空隙（默认 frame center）
                Image(systemName: "person.circle")
                    .background(Color.yellow)
                Text("User:")
                    .background(Color.red)
                // 右侧有空隙（默认 frame center），且空隙不足以展示一个字符
                Text("kingcos | kingcos.me")
                    .background(Color.green)
            }
            .lineLimit(1)
            .frame(width: 200) // 默认为 .center
    //        .frame(width: 200, alignment: .leading) // Image 开始左对齐
            .border(.blue, width: 1)
            
            Spacer()
            
            // 3
            HStack {
                Image(systemName: "person.circle")
                    .background(Color.yellow)
                Text("User:")
                    .background(Color.red)
                Text("kingcos | kingcos.me")
                    .layoutPriority(1) // 默认优先级为 0；设置 1 时优先决定自身尺寸
                    .background(Color.green)
            }
            .lineLimit(1)
            .frame(width: 200)
            .border(.blue, width: 1)
            
            Spacer()
            
            // 4
            HStack {
                Image(systemName: "person.circle")
                    .background(Color.yellow)
                Text("User:")
                    .background(Color.red)
                Text("kingcos | kingcos.me")
                    .background(Color.green)
            }
            .lineLimit(1)
            // 将提示布局系统忽略掉外界条件，让被修饰的 View 使用它在无约束下原本应有的理想尺寸
            .fixedSize()
            .frame(width: 200)
            .border(.blue, width: 1) // HStack 的蓝框已被超出
            // 大部分 View modifier 所做的事情，并不是 “改变 View 上的某个属性”，
            // 而是 “用一个带有相关属性的新 View 来包装原有的 View”
            // 所以互换 frame 和 fixedSize 会失效，是因为 frame 已经是按照理想尺寸布局了
            
            Spacer()
            
            // 5
            HStack {
                Image(systemName: "person.circle")
                    .background(Color.yellow)
                Text("User:")
                    .background(Color.red)
                Text("kingcos | kingcos.me")
                    .layoutPriority(1)
                    .background(Color.green)
            }
            .lineLimit(1)
            .frame(width: 300, alignment: .leading)
            .background(Color.purple)
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
