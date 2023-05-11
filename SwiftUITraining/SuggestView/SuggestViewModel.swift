//
//  SuggestViewModel.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 22/02/2021.
//

import UIKit
import Combine

class SuggestViewModel: ObservableObject {
    private var postResponseSuccessful = false
    @Published var bookImage = UIImage() {
        didSet {
            hasImage = true
        }
    }
    @Published var hasImage = false
    @Published var bookName = ""
    @Published var bookAuthor = ""
    @Published var bookYear = ""
    
    @Published var isSubmitEnabled = false
    
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
        /*
         .allSatisfy can't be used because Apple's documentation states:
         "If the predicate returns false, the publisher produces a false value and finishes."
         And we wan't to continously keep the stream alive to notice further changes.
         */
        Publishers.CombineLatest4($hasImage, $bookName, $bookAuthor, $bookYear)
            .map { b1, b2, b3, b4 in
                b1 && !b2.isEmpty && !b3.isEmpty && !b4.isEmpty
            }
            .receive(on: RunLoop.main)
            .assign(to: \.isSubmitEnabled, on: self)
            .store(in: &cancellableSet)
    }
}
