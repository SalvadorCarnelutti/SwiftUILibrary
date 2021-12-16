//
//  BookDetailComments.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 16/03/2021.
//

import SwiftUI

struct BookDetailComments: View {
    @ObservedObject var bookDetailViewModel: BookDetailViewModel
    
    var body: some View {
        if !bookDetailViewModel.bookComments.isEmpty {
            ScrollView {
                LazyVStack {
                    ForEach(bookDetailViewModel.bookComments.suffix(5)) { bookComment in
                        VStack(alignment: .leading) {
                            HStack {
                                VStack() {
                                    // Maybe switch for RemoteImage
                                    Image(systemName: "person.crop.circle")
                                        .foregroundColor(.blue)
                                        .font(.system(size: 44.0))
                                        .padding(5)
                                    Spacer()
                                }
                                VStack {
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text(bookComment.user.username)
                                            .font(.headline)
                                        Text(bookComment.content)
                                    }
                                    .padding(.bottom, 20)
                                    Divider()
                                    if bookDetailViewModel.isLastBookComment(bookComment) {
                                        Text("View All")
                                            .foregroundColor(Color.deepSkyBlue)
                                            .padding(5)
                                    }
                                }
                            }
                        }
                    }
                }
                .padding()
            }
            .background(Color.white.cornerRadius(5).shadow(radius: 2))
            .padding(.horizontal)
        }
    }
}

struct BookDetailComments_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailComments(bookDetailViewModel: BookDetailViewModel.getMockedViewModel())
    }
}
