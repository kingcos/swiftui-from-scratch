//
//  ContentView.swift
//  DesignCode-1
//
//  Created by kingcos on 2020/1/31.
//  Copyright © 2020 kingcos. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            VStack {
                Text("UI Design")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("accent"))
                    .padding(.top, 16)
                Text("Certificate")
                    .foregroundColor(.white)
            }
            Image("Background")
        }
        .background(Color.black)
        .cornerRadius(10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
