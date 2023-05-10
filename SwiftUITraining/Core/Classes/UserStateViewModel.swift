//
//  UserStateViewModel.swift
//  SwiftUITraining
//
//  Created by Salvador on 5/10/23.
//

import GoogleSignIn

class UserStateViewModel: ObservableObject {
    @Published var loggedIn = false
    
    func handleSignInCases() {
//        let booksScope = "https://www.googleapis.com/auth/books"
//        guard let grantedScopes = GIDSignIn.sharedInstance.currentUser?.grantedScopes,
//        grantedScopes.contains(booksScope) else {
//            grantAdditionalScope()
//            return
//        }
        
        signInUser()
    }
    
    private func signInUser() {
        guard let rootViewController = UIApplication.shared.rootViewController else { return }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { [weak self] signInResult, error in
            guard let result = signInResult else {
                return
            }
            
            self?.loggedIn.toggle()
        }
    }
    
    private func grantAdditionalScope() {
        guard let currentUser = GIDSignIn.sharedInstance.currentUser,
        let rootViewController = UIApplication.shared.rootViewController else {
            return
        }
        
        let additionalScopes = ["https://www.googleapis.com/auth/books"]

        currentUser.addScopes(additionalScopes, presenting: rootViewController) { [weak self] signInResult, error in
            guard error == nil,
            let signInResult = signInResult else { return }
            
            self?.loggedIn.toggle()
        }
    }
    
    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        loggedIn = false
    }
}
