//
//  SuggestViewModel.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 22/02/2021.
//

import Foundation
import Combine

class SuggestViewModel: ObservableObject {
    private var postResponseSuccessful = false
    @Published var bookName = ""
    @Published var bookAuthor = ""
    @Published var bookYear = ""
    @Published var bookTopic = ""
    @Published var bookDescription = ""
    @Published var loading: Bool = false
    
    private var getEncodedRentBody: Data? {
        let encoder = JSONEncoder()
        let suggestionModel = BookSuggestion(author: bookAuthor,
                                             title: bookName,
                                             image: "",
                                             year: bookYear,
                                             genre: bookTopic)
        
        guard let encoded = try? encoder.encode(suggestionModel) else {
            return nil
        }
        
        return encoded
    }
    
    var alertTitle: String {
        return postResponseSuccessful ?
            "Your suggestion was submitted succesfully!" :
            "Sorry, your suggestion couldn't be accepted at the moment"
    }
    
    var alertMessage: String {
        postResponseSuccessful ? "" : "Try again later"
    }
}
