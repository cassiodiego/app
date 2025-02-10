//
//  SplashScreenView.swift
//  App
//
//  Created by Cassio Diego Tavares Campos on 04/12/21.
//  Copyright © 2021 Cassio Diego Tavares Campos. All rights reserved.
//

import SwiftUI

struct SplashScreenView: View {

    let imageName: String

    var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(1/1, contentMode: .fill)
            .edgesIgnoringSafeArea(.all)
    }
}
