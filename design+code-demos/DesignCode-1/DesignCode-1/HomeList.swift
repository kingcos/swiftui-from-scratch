//
//  HomeList.swift
//  DesignCode-1
//
//  Created by kingcos on 2020/2/2.
//  Copyright © 2020 kingcos. All rights reserved.
//

import SwiftUI

struct HomeList: View {
    @State var showSheet = false
    
    var courses = coursesData
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Courses")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                        Text("22 courses")
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
                .padding(.leading, 60.0)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 30.0) {
                        ForEach(courses) { course in
                            GeometryReader { geometry in
                                CourseView(title: course.title,
                                           image: course.image,
                                           color: course.color,
                                           shadowColor: course.shadowColor)
                                    .onTapGesture {
                                        self.showSheet.toggle()
                                }
                                .sheet(isPresented: self.$showSheet) {
                                    ContentView()
                                }
                                .rotation3DEffect(Angle(degrees: Double((geometry.frame(in: .global).minX - 30) / -40)),
                                                  axis: (x: 0, y: 10.0, z: 0))
                            }
                            .frame(width: 246, height: 360)
                        }
                    }
                    .padding(.leading, 30)
                    .padding(.top, 30)
                    .padding(.bottom, 70)
                    Spacer()
                }
                
                CertificateRow()
                Spacer()
            }
            .padding(.top, 78.0)
        }
    }
}

struct HomeList_Previews: PreviewProvider {
    static var previews: some View {
        HomeList()
    }
}

struct CourseView : View {
    var title = "Build an app with SwiftUI"
    var image = "Illustration1"
    var color = Color("background3")
    var shadowColor = Color("backgroundShadow3")
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(30)
                .lineLimit(4)
                .padding(.trailing, 50)
            Spacer()
            Image(image)
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fit)
                .frame(width: 246, height: 150)
                .padding(.bottom, 30)
        }
        .background(color)
        .cornerRadius(30)
        .frame(width: 246, height: 360)
        .shadow(color: shadowColor, radius: 20, x: 0, y: 20)
    }
}

struct Course : Identifiable {
    var id = UUID()
    var title: String
    var image: String
    var color: Color
    var shadowColor: Color
}

let coursesData = [
    Course(title: "Build an app with SwiftUI",
           image: "Illustration1",
           color: Color(hue: 0.677, saturation: 0.701, brightness: 0.788),
           shadowColor: Color(hue: 0.677, saturation: 0.701, brightness: 0.788, opacity: 0.5)),
    Course(title: "Design and animate your UI",
           image: "Illustration2",
           color: Color(red: 0.9254901960784314, green: 0.49411764705882355, blue: 0.4823529411764706),
           shadowColor: Color(red: 0.9254901960784314, green: 0.49411764705882355, blue: 0.4823529411764706, opacity: 0.5)),
    Course(title: "Swift UI Advanced",
           image: "Illustration3",
           color: Color("background7"),
           shadowColor: Color(hue: 0.677, saturation: 0.701, brightness: 0.788, opacity: 0.5)),
    Course(title: "Build an app with SwiftUI",
           image: "Illustration1",
           color: Color(hue: 0.677, saturation: 0.701, brightness: 0.788),
           shadowColor: Color(hue: 0.677, saturation: 0.701, brightness: 0.788, opacity: 0.5)),
    Course(title: "Design and animate your UI",
           image: "Illustration2",
           color: Color(red: 0.9254901960784314, green: 0.49411764705882355, blue: 0.4823529411764706),
           shadowColor: Color(red: 0.9254901960784314, green: 0.49411764705882355, blue: 0.4823529411764706, opacity: 0.5)),
    Course(title: "Swift UI Advanced",
           image: "Illustration3",
           color: Color("background7"),
           shadowColor: Color(hue: 0.677, saturation: 0.701, brightness: 0.788, opacity: 0.5)),
]
