//
//  UserData.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 09/02/2021.
//

struct UserDataSingleton {
    static let shared = UserData()
    var username: String?

    private init() { }
}

struct UserData {
    let username: String
    let password: String
    let id: Int
    
    init() {
        username = "salva"
        password = "salva"
        id = 8
    }
}
