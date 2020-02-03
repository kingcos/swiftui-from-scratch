//
//  CourseView.swift
//  DesignCode-1
//
//  Created by kingcos on 2020/2/3.
//  Copyright © 2020 kingcos. All rights reserved.
//

import SwiftUI

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

struct CourseDetailView : View {
    var title = "Build an app with SwiftUI"
    var image = "Illustration1"
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: [Color("gradient1"),
                                                                 Color("gradient2")]),
                                     startPoint: .top,
                                     endPoint: .bottom))
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text(title)
                        .foregroundColor(Color("primary"))
                        .font(.title)
                        .fontWeight(.heavy)
                        .lineLimit(3)
                    Text("10 sections")
                        .foregroundColor(Color("secondary"))
                        .padding(.top, 0)
                }
                .frame(width: 200)
                
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: screen.width-60, height: 200)
                    .padding()
                Spacer()
            }
            .padding(.top, 20)
            
            VStack {
                HStack {
                    Spacer()
                    ZStack {
                        HStack {
                            Image(systemName: "play.fill")
                                .font(.largeTitle)
                        }
                        .frame(width: 100, height: 80)
                        .background(Color("accent"))
                        .cornerRadius(30)
                        .shadow(color: Color("accentShadow"), radius: 10, x: 0, y: 10)
                        Spacer()
                    }.padding(.all, 30)
                }
                Spacer()
            }
            
            ScrollView {
                CardBottomView()
                    .frame(width: screen.width, height: screen.height)
                    .padding(.top, 400)
            }.frame(width: screen.width)
        }
    }
}

struct CourseView_Previews: PreviewProvider {
    static var previews: some View {
        CourseDetailView()
    }
}
