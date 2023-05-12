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
    @EnvironmentObject var vm: UserStateViewModel
    
    var body: some View {
        if vm.loggedIn {
            TabsView()
        } else {
            LoginForm()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = UserStateViewModel.getMock(loggedIn: false)
        
        LoginView()
            .environmentObject(vm)
    }
}
