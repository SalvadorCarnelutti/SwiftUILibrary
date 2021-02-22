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
                Image("bc_inicio").resizable()
                VStack {
                    Spacer()
                    Image("Group")
                        .padding()
                    CapsuleButton(buttonTitle: "INGRESAR CON GOOGLE",
                                  buttonColor: Color.white,
                                  enabled: true,
                                  buttonAction: logIn)
                    Spacer()
                    Text("Designed, developed and used by woloxers")
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
