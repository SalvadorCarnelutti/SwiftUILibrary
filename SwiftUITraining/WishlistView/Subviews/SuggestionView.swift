//
//  SuggestionView.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 01/03/2021.
//

import SwiftUI

struct SuggestionView: View {
    var urlLinks: [String]
    
    var body: some View {
        if !urlLinks.isEmpty {
            ZStack(alignment: .topLeading) {
                HStack {
                    Text("Suggestions").font(.headline)
                    Spacer()
                }
                .padding(.leading)
                .offset(x: 10)
                ScrollView(.horizontal) {
                    HStack(spacing: 10) {
                        ForEach(0..<urlLinks.count) { index in
                            RemoteImage(url: urlLinks[index])
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 55)
                                .shadow(radius: 3.0)
                        }
                    }
                    .padding(EdgeInsets(top: 30, leading: 20, bottom: 10, trailing: 20))
                }.frame(height: 120)
            }
        }
    }
}

struct SuggestionView_Previews: PreviewProvider {
    static var previews: some View {
        let mockedLinks = Book.getMockedWishlistBooks().map { $0.image }
        
        SuggestionView(urlLinks: mockedLinks)
    }
}
