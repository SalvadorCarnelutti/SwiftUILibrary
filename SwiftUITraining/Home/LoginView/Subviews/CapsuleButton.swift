//
//  CapsuleButton.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 22/02/2021.
//

import SwiftUI

struct CapsuleButton: View {
    let buttonTitle: String
    var buttonColor: Color? = nil
    let enabled: Bool
    let buttonAction: () -> ()
    
    var body: some View {
        Button(action: {
            buttonAction()
        }) {
            Text(buttonTitle).font(.headline).foregroundColor(enabled ? buttonColor! : Color.white)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 24)
        .background(enabled ? Color.clear : Color.gainsboro)
        .clipShape(Capsule())
        .overlay(Capsule().stroke(enabled ? buttonColor! : Color.clear, lineWidth: 2))
        .padding(.vertical, 12)
    } 
    
    static func placeholderFunction() -> () {}
}

struct CapsuleButton_Previews: PreviewProvider {
    static var previews: some View {
        CapsuleButton(buttonTitle: "Button",
                      buttonColor: Color.black,
                      enabled: false,
                      buttonAction: CapsuleButton.placeholderFunction)
    }
}
