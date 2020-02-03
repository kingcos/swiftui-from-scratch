//
//  CourseRow.swift
//  DesignCode-1
//
//  Created by kingcos on 2020/2/3.
//  Copyright © 2020 kingcos. All rights reserved.
//

import SwiftUI

struct CourseRow: View {
    private var sections = sectionData
    
    @State var show = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Continue Watching")
                .font(.system(size: 20))
                .fontWeight(.heavy)
                .padding(.leading, 30)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(sections) { item in
                        CourseItem(title: item.title,
                                   image: item.image,
                                   background: item.background)
                            .frame(width: 230.0, height: 150)
                            .shadow(color: Color("buttonShadow"), radius: 10, x: 0, y: 10)
                            .onTapGesture {
                                self.show.toggle()
                        }.sheet(isPresented: self.$show) {
                            ContentView()
                        }
                    }
                }
                .padding(.leading, 30)
                .padding(.top, 10)
            }
            .frame(height: 200)
        }
    }
}

struct CourseRow_Previews: PreviewProvider {
    static var previews: some View {
        CourseRow()
    }
}

struct CourseItem : View {
    var title = "Build an app with SwiftUI"
    var image = "Illustration1"
    var background = Color("background3")
    
    var body: some View {
        ZStack {
            Image(image)
                .renderingMode(.original)
                .frame(minWidth: 0,
                       maxWidth: .infinity,
                       minHeight: 0,
                       maxHeight: 200)
                .offset(y: 50)
            
            VStack {
                HStack {
                    Text(title)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .lineLimit(3)
                    Spacer()
                }
                Spacer()
            }.padding(20)
            
            ZStack {
                BlurView(style: .extraLight)
                Image(systemName: "play.fill")
                    .foregroundColor(.black)
                    .imageScale(.large)
                
            }.frame(width: 60, height: 50).cornerRadius(20)
            
        }
        .background(background)
        .cornerRadius(30)
    }
}

private struct Section : Identifiable {
    var id = UUID()
    var title: String
    var image: String
    var background: Color
}

private let sectionData = [
    Section(title: "Build an app with  SwiftUI",
            image: "Illustration1",
            background: Color("background2")),
    Section(title: "Design and animate your UI",
            image: "Illustration2",
            background: Color("background7")),
    Section(title: "Animate your UI like a boss",
            image: "Illustration3",
            background: Color("background8")),
    Section(title: "Gestures and Interruptible animations",
            image: "Illustration4",
            background: Color("background9"))
]
