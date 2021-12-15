//
//  Book.swift
//  SwiftUITraining
//
//  Created by Diego Quiros on 15/10/2020.
//

struct Book: Codable, Equatable, Identifiable {
    var id: Int
    var author: String
    var title: String
    var genre: String
    var year: String
    var image: String
    var status: String
    
    mutating func setAsUnavailable() {
        self.status = "Unavailable"
    }
}
