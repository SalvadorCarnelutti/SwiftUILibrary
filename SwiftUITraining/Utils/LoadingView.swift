//
//  LoadingView.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 09/03/2021.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

struct LoadingView<Content>: View where Content: View {
    @Binding var isShowing: Bool
    var content: () -> Content

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {

                self.content()
                    .disabled(isShowing)
                    .blur(radius: isShowing ? 3 : 0)

                VStack {
                    Text("Loading...")
                    ActivityIndicator(isAnimating: .constant(true),
                                      style: .large)
                }
                .frame(width: geometry.size.width / 2,
                       height: geometry.size.height / 5)
                .background(Color.secondary.colorInvert())
                .foregroundColor(Color.primary)
                .cornerRadius(20)
                .opacity(isShowing ? 1 : 0)

            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(isShowing: .constant(true)) {
            NavigationView {
                Text("Test to se how it gets blurred when loading")
                    .frame(alignment: .center)
            }
        }
    }
}
