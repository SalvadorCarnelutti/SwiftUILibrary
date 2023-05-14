//
//  LoadingView.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 09/03/2021.
//

import SwiftUI

struct LoadingView<Content>: View where Content: View {
    @Binding var isShowing: Bool
    var content: () -> Content

    var body: some View {
        ZStack(alignment: .center) {
            self.content()
                .disabled(isShowing)

            VStack {
                Text("Loading...")
                    .font(.headline)
                ProgressView()
            }
            .frame(width: 200,
                   height: 160)
            .background(Color.secondary.colorInvert())
            .foregroundColor(Color.primary)
            .cornerRadius(20)
            .opacity(isShowing ? 1 : 0)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(isShowing: .constant(true)) {
            NavigationView {
                Text("Test to se how it gets when loading")
                    .frame(alignment: .center)
            }
        }
    }
}
