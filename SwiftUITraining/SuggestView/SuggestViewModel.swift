//
//  SuggestViewModel.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 22/02/2021.
//

import UIKit
import Combine

class SuggestViewModel: ObservableObject {
    private var postResponseSuccessful = true
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
        publishIsSubmitEnabled()
    }
    
    var alertTitle: String {
        "Work in progress"
    }
    
    var alertMessage: String {
        "There is no Google Books API endpoint for suggesting a new book"
    }
    
    func clearForm() {
        bookImage = UIImage()
        hasImage = false
        bookName = ""
        bookAuthor = ""
        bookYear = ""
    }
    
    private func publishIsSubmitEnabled() {
        /*
         .allSatisfy can't be used because Apple's documentation states:
         "If the predicate returns false, the publisher produces a false value and finishes."
         And we want to continously keep the stream alive to notice further changes.
         */
        Publishers.CombineLatest4($hasImage, $bookName, $bookAuthor, $bookYear)
            .map { b1, b2, b3, b4 in
                b1 && Self.isAllowedName(b2.trimmed) && Self.isAllowedAuthor(b3.trimmed) && Self.isAllowedYear(b4)
            }
            .receive(on: RunLoop.main)
            .assign(to: \.isSubmitEnabled, on: self)
            .store(in: &cancellableSet)
    }
    
    private static func isAllowedName(_ bookName: String) -> Bool {
        bookName.isNotEmpty && bookName.onlyCharacters
    }
    
    private static func isAllowedAuthor(_ bookAuthor: String) -> Bool {
        bookAuthor.isNotEmpty && bookAuthor.onlyCharacters
    }
    
    private static func isAllowedYear(_ bookYear: String) -> Bool {
        bookYear.count == 4 && bookYear.onlyNumbers
    }
}
