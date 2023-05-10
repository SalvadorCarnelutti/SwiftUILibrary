//
//  LoginView.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 06/02/2021.
//

import SwiftUI
import GoogleSignInSwift
import GoogleSignIn

struct LoginView: View {
    @State private var loggedIn = false
    
    var body: some View {
        if loggedIn {
            TabsView()
        } else {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.blue, .deepSkyBlue]), startPoint: .top, endPoint: .bottom)
                VStack {
                    Spacer()
                    Image(systemName: "character.book.closed.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 100.0))
                        .padding()
                    Text("E-books")
                        .font(.largeTitle)
                        .foregroundColor(Color.white)
                        .padding(.bottom)
                    
                    GoogleSignInButton(action: handleSignInButton)
                        .padding(.horizontal, 40)
                    
                    Spacer()
                    Text("Work in progress")
                        .font(.footnote)
                        .foregroundColor(Color.black)
                        .padding()
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
    
    private func handleSignInButton() {
        let booksScope = "https://www.googleapis.com/auth/books"
        let grantedScopes = GIDSignIn.sharedInstance.currentUser?.grantedScopes
        
        if grantedScopes == nil || !grantedScopes!.contains(booksScope) {
          // Request additional Drive scope.
            grantAdditionalScope()
        } else {
            signInUser()
        }
    }
    
    private func signInUser() {
        guard let rootViewController = UIApplication.shared.rootViewController else { return }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { signInResult, error in
            guard let result = signInResult else {
                return
            }
            loggedIn.toggle()
        }
    }
    
    private func grantAdditionalScope() {
        guard let currentUser = GIDSignIn.sharedInstance.currentUser,
        let rootViewController = UIApplication.shared.rootViewController else {
            return
        }
        
        let additionalScopes = ["https://www.googleapis.com/auth/books"]

        currentUser.addScopes(additionalScopes, presenting: rootViewController) { signInResult, error in
            guard error == nil,
            let signInResult = signInResult else { return }
            loggedIn.toggle()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
