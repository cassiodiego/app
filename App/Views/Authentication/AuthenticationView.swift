//
//  AuthenticationView.swift
//  Authenticator
//
//  Created by Cassio Diego T. Campos on 04/12/21.
//  Copyright © 2021 Cassio Diego T. Campos. All rights reserved.
//


import SwiftUI

struct AuthenticationView: View {
    
    @EnvironmentObject var authState: AuthenticationState

    @State var authType = AuthenticationType.login
    
    var body: some View {
        ZStack {
            VStack(spacing: 32) {
                LogoTitle()
                if (!authState.isAuthenticating) {
                    AuthenticationFormView(authType: $authType)
                } else {
                    ProgressView()
                }
                
                SignInAppleButton {
                    self.authState.login(with: .signInWithApple)
                }
                .frame(width: 130, height: 44)
            }
            .offset(y: UIScreen.main.bounds.width > 320 ? -75 : 0)
        }
        
    }
    
}
