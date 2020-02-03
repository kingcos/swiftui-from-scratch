//
//  CertificateItemView.swift
//  DesignCode-1
//
//  Created by kingcos on 2020/2/3.
//  Copyright © 2020 kingcos. All rights reserved.
//

import SwiftUI

struct CertificateItemView: View {
    var title = "UI Design"
    var image = "Certificate1"
    var background = Color.black
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Text("certificate")
                        .foregroundColor(Color(.displayP3,
                                               red: 0.615686274509804,
                                               green: 0.8588235294117647,
                                               blue: 0.9058823529411765))
                }
                .padding()
                Spacer()
                Image("Logo")
                    .resizable()
                    .renderingMode(.original)
                    .frame(width: 30, height: 30)
                    .padding(.trailing, 20.0)
            }
            
            HStack {
                Spacer()
            }
            
            Image(image)
                .renderingMode(.original)
                .frame(minWidth: 0,
                       maxWidth: .infinity,
                       minHeight: 0,
                       maxHeight: 200)
                .offset(y: 50)
        }
        .background(background)
        .cornerRadius(10)
    }
}

struct CertificateItemView_Previews: PreviewProvider {
    static var previews: some View {
        CertificateItemView()
    }
}

//struct CardView: View {
//    var body: some View {
//        VStack {
//            Text("Card Back")
//        }
//        .frame(width: 340.0, height: 220.0)
//    }
//}
//
//struct CertificateView: View {
//    var item = Certificate(title: "UI Design", image: "Background", width: 340, height: 220)
//    
//    var body: some View {
//        VStack {
//            HStack {
//                VStack(alignment: .leading) {
//                    Text(item.title)
//                        .font(.headline)
//                        .fontWeight(.bold)
//                        .foregroundColor(Color("accent"))
//                        .padding(.top)
//                    Text("Certificate")
//                        .foregroundColor(.white)
//                }
//                Spacer()
//                Image("Logo")
//                    .resizable()
//                    .frame(width: 30.0, height: 30.0)
//            }
//            .padding(.horizontal)
//            Spacer()
//            Image(item.image)
//                .frame(minWidth: 0,
//                       maxWidth: .infinity,
//                       minHeight: 0,
//                       maxHeight: .infinity)
//                .offset(y: 50)
//        }
//        .frame(width: CGFloat(item.width), height: CGFloat(item.height))
//        .background(Color.black)
//        .cornerRadius(10)
//        .shadow(radius: 10)
//    }
//}
