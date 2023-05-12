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
                    ForEach(bookDetailViewModel.displayedBookComments) { bookComment in
                        LazyVStack(alignment: .leading) {
                            HStack {
                                VStack {
                                    Image(systemName: "person.crop.circle")
                                        .foregroundColor(.blue)
                                        .font(.system(size: 44.0))
                                        .padding(5)
                                    Spacer()
                                }
                                VStack {
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text(bookComment.username)
                                            .font(.headline)
                                        Text(bookComment.content)
                                    }
                                    .padding(.bottom, 12)
                                    Divider()
                                        .opacity(bookDetailViewModel.commentHasDivider(bookComment) ? 1.0 : 0.0)
                                }
                            }
                        }
                    }
                    HStack {
                        if bookDetailViewModel.canDisplayMore {
                            Button("View all") {
                                bookDetailViewModel.commentsFullyShown.toggle()
                            }
                            .foregroundColor(Color.deepSkyBlue)
                            .padding(12)
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
