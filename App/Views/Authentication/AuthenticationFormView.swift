//
//  AuthenticationFormView.swift
//  App
//
//  Created by Cassio Diego Tavares Campos on 04/12/21.
//  Copyright © 2021 Cassio Diego Tavares Campos. All rights reserved.
//

import SwiftUI

struct AuthenticationFormView: View {
    
    @EnvironmentObject var authState: AuthenticationState
    @State var email: String = ""
    @State var password: String = ""
    @State var passwordConf: String = ""
    @State var isShowingPassword = false
    
    @Binding var authType: AuthenticationType
    
    var body: some View {
        VStack(spacing: 16) {
            TextField("Email", text: $email)
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
            
            if isShowingPassword {
                TextField("Senha", text: $password)
                    .textContentType(.password)
                    .autocapitalization(.none)
            } else {
                SecureField("Senha", text: $password)
            }
            
            if authType == .signup {
                if isShowingPassword {
                    TextField("Confirmação de senha", text: $passwordConf)
                        .textContentType(.password)
                        .autocapitalization(.none)
                } else {
                    SecureField("Confirmação de senha", text: $passwordConf)
                }
            }
            
            Toggle("Mostrar senha", isOn: $isShowingPassword)
                .foregroundColor(.gray)
            
            Button(action: emailAuthenticationTapped) {
                Text(authType.text)
                    .font(.callout)
            }
            .buttonStyle(AuthenticatorButtonStyle())
            .disabled(email.count == 0 && password.count == 0)
            
            Button(action: footerButtonTapped) {
                Text(authType.footerText)
                    .font(.callout)
            }
            .foregroundColor(.gray)
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .frame(width: 288)
        .alert(item: $authState.error) { error in
            Alert(title: Text("Erro"), message: Text(error.localizedDescription))
        }
    }
    
    private func emailAuthenticationTapped() {
        switch authType {
        case .login:
            authState.login(with: .emailAndPassword(email: email, password: password))
            
        case .signup:
            authState.signup(email: email, password: password, passwordConfirmation: passwordConf)
        }
    }
    
    private func footerButtonTapped() {
        clearFormField()
        authType = authType == .signup ? .login : .signup
    }
    
    private func clearFormField() {
        email = ""
        password = ""
        passwordConf = ""
        isShowingPassword = false
    }
    
}
