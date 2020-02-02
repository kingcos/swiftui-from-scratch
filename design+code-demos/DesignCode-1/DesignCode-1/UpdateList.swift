//
//  UpdateList.swift
//  DesignCode-1
//
//  Created by kingcos on 2020/2/3.
//  Copyright © 2020 kingcos. All rights reserved.
//

import SwiftUI

struct UpdateList: View {
    @State var show = false
    
    var updates = updateData
    
    var body: some View {
        NavigationView {
            List(updates) { item in
                NavigationLink(destination: Text("1")) {
                    VStack(alignment: .leading) {
                        Text(item.title)
                            .font(.headline)
                        Text(item.text)
                            .lineLimit(2)
                            .lineSpacing(4)
                            .font(.subheadline)
                            .frame(height: 50)
                        Text(item.date)
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                        
                        Spacer()
                    }.padding(.leading, 4)
                }
            }
            .navigationBarTitle(Text("Updates"))
            .navigationBarItems(trailing:
                Button(action: { self.show.toggle() }) {
                    Image(systemName: "gear")
            })
        }
        .sheet(isPresented: $show) { Text("Updates") }
    }
}

struct UpdateList_Previews: PreviewProvider {
    static var previews: some View {
        UpdateList()
    }
}

struct Update: Identifiable {
    var id = UUID()
    var image: String
    var title: String
    var text: String
    var date: String
}

let updateData = [
    Update(image: "Illustration1",
           title: "SwiftUI",
           text: "Take your static design to the next level and build real apps with the simplicity of a prototpying tool. The best way to beginners to learn code, and the most efficient way for developers to learn design.",
           date: "JUN 26"),
    Update(image: "Illustration2",
           title: "Framer X",
           text: "Framer makes it incredibly easy to add complex user interactions inside your prototype, taking your design and code components to the next level. Playground allows you to quickly test new concepts within the all - new in -app code editor. You can combine your current app flow with new code components created in Playground.",
           date: "JUN 11"),
    Update(image: "Illustration3",
           title: "CSS Layout",
           text: "Learn how to combine CSS Grid, Flexbox, animations and responsive design to create a beautiful prototype in CodePen.",
           date: "MAY 26"),
    Update(image: "Illustration4",
           title: "React Native",
           text: "Learn how to implement gestures, Lottie animations and Firebase login.",
           date: "MAY 15"),
    Update(image: "Certificate1",
           title: "Unity",
           text: "Unity course teaching basics, C#, assets, level design and gameplay",
           date: "MAR 19")
]
