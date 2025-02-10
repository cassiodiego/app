//
//  HomeView.swift
//  App
//
//  Created by Cassio Diego Tavares Campos on 04/12/21.
//  Copyright © 2021 Cassio Diego Tavares Campos. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var authState: AuthenticationState
    
    @State var isLoading = false
    @State var error: NSError?
    let url = URL(string: "https://cassiodiego.com")!

    var body: some View {
        NavigationView {
            ZStack {
                WebView(url: url, isLoading: $isLoading, error: $error)
                    .opacity(!isLoading && error == nil ? 1 : 0)
                
                if self.isLoading {
                    ProgressView()
                } else if self.error != nil {
                    Text(error!.localizedDescription)
                }
            }
            .background(Color(UIColor.systemBackground))
            .navigationBarTitle("App", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: signoutTapped, label: {
                Image(systemName: "person.circle")
                Text("Sair")
            }))
            .edgesIgnoringSafeArea(.vertical)
        }
    }
    
    private func signoutTapped() {
        authState.signout()
    }
}
