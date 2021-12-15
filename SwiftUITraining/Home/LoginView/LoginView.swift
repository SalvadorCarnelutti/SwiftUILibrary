//
//  LoginView.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 06/02/2021.
//

import SwiftUI

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
                    
                    CapsuleButton(buttonTitle: "LOG IN WITH GOOGLE",
                                  buttonColor: Color.white,
                                  enabled: true,
                                  buttonAction: logIn)
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
    
    private func logIn() {
        loggedIn.toggle()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
