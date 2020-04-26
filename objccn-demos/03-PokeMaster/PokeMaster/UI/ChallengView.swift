//
//  ChallengView.swift
//  PokeMaster
//
//  Created by kingcos on 2020/4/27.
//  Copyright © 2020 OneV's Den. All rights reserved.
//

import SwiftUI

struct ChallengView: View {
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                Circle()
                    .fill(Color.red)
            }
        }
        .frame(width: 100, height: 100)
        .background(Color.gray.opacity(0.3))
        .offset(y: -100)
    }
}

struct ChallengView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengView()
    }
}
