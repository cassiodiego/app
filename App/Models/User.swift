//
//  User.swift
//  App
//
//  Created by Cassio Diego Tavares Campos on 19/02/25.
//

import Foundation

struct User: Identifiable, Equatable {
    let id: String
    let email: String
    let creationDate: Date?
    let lastLoginDate: Date?

    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id &&
               lhs.email == rhs.email &&
               lhs.creationDate == rhs.creationDate &&
               lhs.lastLoginDate == rhs.lastLoginDate
    }
}
