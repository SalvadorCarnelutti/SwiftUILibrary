//
//  LoginForm.swift
//  SwiftUITraining
//
//  Created by Salvador on 5/10/23.
//

import SwiftUI
import GoogleSignInSwift

struct LoginForm: View {
    @EnvironmentObject var vm: UserStateViewModel
    
    var body: some View {
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
                
                GoogleSignInButton(action: vm.handleSignInCases)
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

struct LoginForm_Previews: PreviewProvider {
    static var previews: some View {
        LoginForm()
    }
}
