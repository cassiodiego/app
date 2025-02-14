//
//  AuthenticationState.swift
//  App
//
//  Created by Cassio Diego Tavares Campos on 04/12/21.
//  Copyright © 2021 Cassio Diego Tavares Campos. All rights reserved.
//

import Combine
import AuthenticationServices
import FirebaseAuth

enum LoginOption {
    case signInWithApple
    case emailAndPassword(email: String, password: String)
}

class AuthenticationState: NSObject, ObservableObject {
    
    @Published var loggedInUser: User?
    @Published var isAuthenticating = false
    @Published var error: NSError?
    
    static let shared = AuthenticationState()
    
    private let auth = Auth.auth()
    private var currentNonce: String?
    private var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle?
    
    public override init() {
        super.init()
        self.loggedInUser = auth.currentUser
        authStateDidChangeListenerHandle = auth.addStateDidChangeListener(authStateChanged)
    }
    
    private func authStateChanged(with auth: Auth, user: User?) {
        guard user != self.loggedInUser else { return }
        self.loggedInUser = user
    }
    
    func login(with loginOption: LoginOption) {
        isAuthenticating = true
        error = nil
                
        switch loginOption {
        case .signInWithApple:
            handleSignInWithApple()
            
        case let .emailAndPassword(email, password):
            handleSignInWith(email: email, password: password)
        }
    }
    
    func signup(email: String, password: String, passwordConfirmation: String) {
        guard password == passwordConfirmation else {
            self.error = NSError(domain: "", code: 9210, userInfo: [NSLocalizedDescriptionKey: "A senha e a confirmação não coincidem"])
            return
        }
        
        isAuthenticating = true
        error = nil
        
        auth.createUser(withEmail: email, password: password, completion: handleAuthResultCompletion)
    }
    
    private func handleSignInWith(email: String, password: String) {
        auth.signIn(withEmail: email, password: password, completion: handleAuthResultCompletion)
    }
    
    private func handleAuthResultCompletion(auth: AuthDataResult?, error: Error?) {
        DispatchQueue.main.async {
            self.isAuthenticating = false
            if let user = auth?.user {
                self.loggedInUser = user
            } else if let error = error {
                self.error = error as NSError
            }
        }
    }
  
    func signout() {
        do {
            try auth.signOut()
            self.loggedInUser = nil
        } catch let signOutError as NSError {
            self.error = signOutError
        }
    }
}

extension AuthenticationState: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    private func handleSignInWithApple() {
        let nonce = String.randomNonceString()
        currentNonce = nonce
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = nonce.sha256
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            fatalError("Nenhuma janela disponível")
        }
        return window
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Estado inválido: um callback de login foi recebido, mas nenhuma solicitação de login foi enviada.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Não foi possível obter o token de identidade")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Não foi possível serializar a string do token a partir dos dados: \(appleIDToken.debugDescription)")
                return
            }
            let credential = OAuthProvider.appleCredential(
                withIDToken: idTokenString,
                rawNonce: nonce,
                fullName: nil
             )
            auth.signIn(with: credential, completion: handleAuthResultCompletion)
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Erro ao entrar com a Apple: \(error)")
        self.isAuthenticating = false
        self.error = error as NSError
    }
}
