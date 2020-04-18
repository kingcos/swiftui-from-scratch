//
//  LoadingView.swift
//  PokeMaster
//
//  Created by kingcos on 2020/4/18.
//  Copyright © 2020 OneV's Den. All rights reserved.
//

import SwiftUI
import UIKit

struct LoadingView: UIViewRepresentable {
    var isAnimating = true
    var style: UIActivityIndicatorView.Style = .medium
    
    typealias UIViewType = UIActivityIndicatorView
    
    func makeUIView(context: Context) -> UIViewType {
        let uiView = UIActivityIndicatorView()
        
        uiView.style = style
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
        
        return uiView
    }
    
    func updateUIView(_ uiView: UIViewType,
                      context: Context) {
        uiView.style = style
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
