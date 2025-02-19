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
    
    var body: some View {
        NavigationView {
            ZStack {
                if let user = authState.loggedInUser {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Email: \(user.email)")
                            .font(.headline)
                        if let creationDate = user.creationDate {
                            Text("Data de criação: \(creationDate.formatted())")
                                .font(.subheadline)
                        }
                        if let lastLoginDate = user.lastLoginDate {
                            Text("Último acesso: \(lastLoginDate.formatted())")
                                .font(.subheadline)
                        }
                    }
                    .padding()
                } else {
                    Text("Não autorizado")
                        .font(.headline)
                }
            }
            .background(Color(UIColor.systemBackground))
            .navigationBarTitle("App", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: signoutTapped, label: {
                Image(systemName: "power")
                Text("Sair")
            }))
            .edgesIgnoringSafeArea(.vertical)
        }
    }
    
    private func signoutTapped() {
        authState.signout()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(AuthenticationState.shared)
    }
}
