//
//  AuthenticationType.swift
//  App
//
//  Created by Cassio Diego Tavares Campos on 04/12/21.
//  Copyright © 2021 Cassio Diego Tavares Campos. All rights reserved.
//
    
import Foundation

enum AuthenticationType: String {
    case login
    case signup
    
    var text: String {
        rawValue.capitalized
    }
    
    var assetBackgroundName: String {
        self == .login ? "Entrar" : "Cadastrar"
    }

    var footerText: String {
        switch self {
        case .login:
            return "Não tem uma conta? Cadastre-se!"
            
        case .signup:
            return "Já possui conta? Conecte-se!"
        }
    }
}
