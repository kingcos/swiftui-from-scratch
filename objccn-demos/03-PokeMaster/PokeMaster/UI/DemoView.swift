//
//  DemoView.swift
//  PokeMaster
//
//  Created by kingcos on 2020/4/27.
//  Copyright © 2020 OneV's Den. All rights reserved.
//

import SwiftUI

struct DemoView: View {
    var body: some View {
        // 隐式
//        HStack { // 默认使用 VerticalAlignment.center
//            Image(systemName: "person.circle")
//            Text("User:")
//                .font(.footnote)
//            Text("onevcat | Wei Wang")
//        }
        
        // 显式
        HStack(alignment: .center) {
            Image(systemName: "person.circle")
                .alignmentGuide(VerticalAlignment.center) { d in
                    d[VerticalAlignment.center]
            }
            Text("User:")
                .font(.footnote)
                .alignmentGuide(VerticalAlignment.center) { d in
                    d[VerticalAlignment.center]
                }
            Text("onevcat | Wei Wang")
                .alignmentGuide(VerticalAlignment.center) { d in
                    d[VerticalAlignment.center]
                }
            }
    }
}

struct DemoView_Previews: PreviewProvider {
    static var previews: some View {
        DemoView()
    }
}
