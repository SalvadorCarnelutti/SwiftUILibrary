//
//  BookDetailCommentsView.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 16/03/2021.
//

import SwiftUI

struct BookDetailCommentsView: View {
    @ObservedObject var bookDetailViewModel: BookDetailViewModel
    
    var body: some View {
        if bookDetailViewModel.bookComments.isNotEmpty {
            VStack {
                List {
                    Section {
                        ForEach(bookDetailViewModel.displayedBookComments) { bookComment in
                            BookDetailCommentView(bookComment: bookComment)
                        }
                    } footer: {
                        if bookDetailViewModel.canDisplayMore {
                            HStack {
                                Spacer()
                                Button("View All") {
                                    bookDetailViewModel.commentsFullyShown.toggle()
                                }
                                .foregroundColor(Color.deepSkyBlue)
                                Spacer()
                            }
                            .listSectionSeparator(.hidden, edges: .bottom)
                        }
                    }
                }
                .padding(.trailing, 15)
                .cornerRadius(5)
                .listStyle(.inset)
            }
            .background(Color.white.cornerRadius(5).shadow(radius: 2))
            .padding(.horizontal)
        }
    }
}

struct BookDetailCommentsView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailCommentsView(bookDetailViewModel: BookDetailViewModel.getMockedViewModel())
    }
}

