//
//  LogoTitleView.swift
//  App
//
//  Created by Cassio Diego Tavares Campos on 04/12/21.
//  Copyright © 2021 Cassio Diego Tavares Campos. All rights reserved.
//

import SwiftUI

struct LogoTitle: View {
    var body: some View {
        VStack {
            Image("Logo")
                .resizable()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                .shadow(radius: 5)
            
            Text("App")
                .lineLimit(2)
            
            Text("cassiodiego.com")
                .font(.headline)
            
        }
        .foregroundColor(.gray)
    }
}

