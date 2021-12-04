//
//  ContentView.swift
//  Authenticator
//
//  Created by Cassio Diego T. Campos on 04/12/21.
//  Copyright © 2021 Cassio Diego T. Campos. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var authState: AuthenticationState
     
     var body: some View {
         Group {
             if authState.loggedInUser != nil {
                 HomeView()
             } else {
                 AuthenticationView(authType: .login)
             }
         }
         .animation(.easeInOut)
         .transition(.move(edge: .bottom))
     }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
