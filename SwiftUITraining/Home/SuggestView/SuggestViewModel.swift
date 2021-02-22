//
//  SuggestViewModel.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 22/02/2021.
//

import Foundation
import Combine

class SuggestViewModel: ObservableObject {
    private let _userData = UserDataSingleton.shared
    private let _suggestURL = "https://swift-training-backend.herokuapp.com/books"
    private var _postResponseSuccessful = false
    @Published var bookName = ""
    @Published var bookAuthor = ""
    @Published var bookYear = ""
    @Published var bookTopic = ""
    @Published var bookDescription = ""
    
    func postBookSuggestion(completionHandler: @escaping () -> ()) {
        guard let httpBody = getEncodedRentBody else { return }
        var request =  URLRequest(url: URL(string: _suggestURL)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = httpBody
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { [weak self] data, response, error in
            completionHandler()
            self?._postResponseSuccessful = response != nil
        }
        task.resume()
    }
    
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
        return _postResponseSuccessful ?
            "Your suggestion was submitted succesfully!" :
            "Sorry, your suggestion couldn't be accepted at the moment"
    }
    
    var alertMessage: String {
        return _postResponseSuccessful ? "" : "Try again later"
    }
}
