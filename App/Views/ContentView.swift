//
//  ContentView.swift
//  App
//
//  Created by Cassio Diego Tavares Campos on 04/12/21.
//  Copyright © 2021 Cassio Diego Tavares Campos. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var authState: AuthenticationState
    
    var body: some View {
        Group {
            if authState.loggedInUser != nil {
                HomeView()
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut, value: authState.loggedInUser)
            } else {
                AuthenticationView(authType: .login)
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut, value: authState.loggedInUser)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthenticationState())
    }
}
