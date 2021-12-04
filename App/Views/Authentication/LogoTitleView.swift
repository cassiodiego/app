//
//  LogoTitleView.swift
//  Authenticator
//
//  Created by Cassio Diego T. Campos on 04/12/21.
//  Copyright © 2021 Cassio Diego T. Campos. All rights reserved.
//

import SwiftUI

struct LogoTitle: View {
    var body: some View {
        VStack {
//            Image("logo")
//                .resizable()
//                .frame(width: 80, height: 80)
            
            Text("Authenticator")
                .lineLimit(2)
            
            Text("cassiodiego.com")
                .font(.headline)
            
        }
        .foregroundColor(.gray)
    }
}

