//
//  BookDetailComment.swift
//  SwiftUITraining
//
//  Created by Salvador on 5/13/23.
//

import SwiftUI

struct BookDetailCommentView: View {
    let bookComment: BookComment
    
    var body: some View {
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
            }
        }
    }
}


struct BookDetailCommentView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailCommentView(bookComment: BookComment.getMockedBookComment())
            .frame(height: 100)
    }
}
