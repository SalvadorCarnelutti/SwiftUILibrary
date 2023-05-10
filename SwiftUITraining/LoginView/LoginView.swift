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
                // Inspect error
                return
            }
            loggedIn.toggle()
        }
    }
    
    private func grantAdditionalScope() {
        let additionalScopes = ["https://www.googleapis.com/auth/books"]
        guard let currentUser = GIDSignIn.sharedInstance.currentUser else {
            return ;  /* Not signed in. */
        }
        
        guard let rootViewController = UIApplication.shared.rootViewController else { return }

        currentUser.addScopes(additionalScopes, presenting: rootViewController) { signInResult, error in
            guard error == nil else { return }
            guard let signInResult = signInResult else { return }
            // Check if the user granted access to the scopes you requested.
            loggedIn.toggle()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

extension UIApplication {
  var currentKeyWindow: UIWindow? {
    UIApplication.shared.connectedScenes
      .filter { $0.activationState == .foregroundActive }
      .map { $0 as? UIWindowScene }
      .compactMap { $0 }
      .first?.windows
      .filter { $0.isKeyWindow }
      .first
  }

  var rootViewController: UIViewController? {
    currentKeyWindow?.rootViewController
  }
}
