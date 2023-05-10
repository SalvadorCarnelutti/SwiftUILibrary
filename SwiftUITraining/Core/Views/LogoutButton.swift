//
//  LogoutButton.swift
//  SwiftUITraining
//
//  Created by Salvador on 5/10/23.
//

import SwiftUI

struct LogoutButton: View {
    var buttonAction: () -> ()
    
    var body: some View {
        Button {
            buttonAction()
        } label: {
            Text("Logout")
        }
    }
}

struct LogoutButton_Previews: PreviewProvider {
    static var previews: some View {
        let mockFunc: () -> () = {}
        
        LogoutButton(buttonAction: mockFunc)
    }
}
