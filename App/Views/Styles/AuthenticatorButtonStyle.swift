//
//  XCAButtonStyle.swift
//  App
//
//  Created by Cassio Diego Tavares Campos on 04/12/21.
//  Copyright © 2021 Cassio Diego Tavares Campos. All rights reserved.
//

import SwiftUI

struct AuthenticatorButtonStyle: ButtonStyle {
 
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 130, height: 44)
            .foregroundColor(Color.white)
            .background(Color.black)
            .cornerRadius(8)
    }
}
