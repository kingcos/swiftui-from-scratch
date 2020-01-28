//
//  HomeView.swift
//  DesignCode
//
//  Created by kingcos on 2020/1/28.
//  Copyright © 2020 kingcos. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @Binding var showProfile: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text("Watching")
                    .font(.system(size: 28, weight: .bold))
                Spacer()
                
                // 将 State 作为 Binding 传入
                AvatarView(showProfile: $showProfile)
            }
            .padding(.horizontal)
            .padding(.leading, 30 - 16) // 与下面的 ScrollView 对齐（默认水平为 16）
            .padding(.top, 30)
            
            // 横向 ScrollView
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(sectionData) { item in
                        SectionView(section: item)
                    }
                }
                .padding(30)
                .padding(.bottom, 30)
            }
            
            Spacer()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showProfile: .constant(false))
    }
}

struct SectionView: View {
    var section: Section
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text(section.title)
                    .font(.system(size: 24, weight: .black))
                    .frame(width: 160, alignment: .leading)
                    .foregroundColor(Color.white)
                Spacer()
                Image(section.logo)
            }
            
            Text(section.text.uppercased())
                .frame(maxWidth: .infinity, alignment: .leading)
            
            section.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 210)
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .frame(width: 275, height: 275)
        .background(section.color)
        .cornerRadius(30)
        .shadow(color: section.color.opacity(0.3), radius: 20, x: 0, y: 20)
    }
}

struct Section: Identifiable {
    // 自动生成非重复 id
    var id = UUID()
    var title: String
    var text: String
    var logo: String
    var image: Image
    var color: Color
}

let sectionData = [
    Section(title: "Prototype designs in SwiftUI",
            text: "18 Sections",
            logo: "Logo1",
            image: Image("Card1"),
            color: Color("card1")),
    
    Section(title: "Build a SwiftUI app",
            text: "20 Sections",
            logo: "Logo1",
            image: Image(uiImage: #imageLiteral(resourceName: "Card4")),
            color: Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))),
    
    Section(title: "SwiftUI Advanced",
            text: "20 Sections",
            logo: "Logo1",
            image: Image(uiImage: #imageLiteral(resourceName: "Card3")),
            color: Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)))
]
