//
//  UserStateViewModel.swift
//  SwiftUITraining
//
//  Created by Salvador on 5/10/23.
//

import GoogleSignIn

class UserStateViewModel: ObservableObject {
    @Published var loggedIn = false
    
    private var requiresBooksScope: Bool {
        let booksScope = "https://www.googleapis.com/auth/books"
        let grantedScopes = GIDSignIn.sharedInstance.currentUser?.grantedScopes
        
        return grantedScopes == nil || !grantedScopes!.contains(booksScope)
    }
    
    func signInUser() {
        handleSignInCases()
    }
    
    private func handleSignInCases() {
        guard let rootViewController = UIApplication.shared.rootViewController else { return }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { [weak self] signInResult, error in
            guard signInResult != nil,
            let self = self else {
                return
            }
            
            guard !self.requiresBooksScope else {
                self.grantAdditionalScope()
                return
            }
            
            self.loggedIn.toggle()
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
            signInResult != nil else { return }
            
            self?.loggedIn.toggle()
        }
    }
    
    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        loggedIn = false
    }
}
