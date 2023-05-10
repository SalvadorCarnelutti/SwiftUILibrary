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
    @Published var bookDescription = ""
    
    @Published var isSubmitDisabled = true
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    init() {
        publishIsSubmitDisabled()
    }
    
    private var getEncodedRentBody: Data? {
        let encoder = JSONEncoder()
        let suggestionModel = BookSuggestion(author: bookAuthor,
                                             title: bookName,
                                             image: "",
                                             year: bookYear)
        
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
    
    private func publishIsSubmitDisabled() {
        Publishers.CombineLatest4($bookName, $bookAuthor, $bookYear, $bookDescription)
            .map { b1, b2, b3, b4 in
                b1.isEmpty || b2.isEmpty || b3.isEmpty || b4.isEmpty
            }
            .receive(on: RunLoop.main)
            .assign(to: \.isSubmitDisabled, on: self)
            .store(in: &cancellableSet)
    }
}
