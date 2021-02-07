//
//  LoginView.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 06/02/2021.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("bc_inicio").resizable()
                VStack {
                    Spacer()
                    Image("Group")
                        .padding()
                    NavigationLink(destination: HomeView()) {
                            Text("INGRESAR CON GOOGLE").font(.headline).foregroundColor(Color.white)
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 24)
                    .clipShape(Capsule())
                    .overlay(Capsule().stroke(Color.white, lineWidth: 2))
                    .padding(.vertical, 12)
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
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
