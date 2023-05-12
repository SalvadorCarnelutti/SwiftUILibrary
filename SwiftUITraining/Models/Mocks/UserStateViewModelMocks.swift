//
//  UserStateViewModelMocks.swift
//  SwiftUITraining
//
//  Created by Salvador on 5/11/23.
//

extension UserStateViewModel {
    static func getMock(loggedIn: Bool) -> UserStateViewModel {
        let envObj = UserStateViewModel()
        envObj.loggedIn = loggedIn
        return envObj
    }
}
