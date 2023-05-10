//
//  Book.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 15/10/2020.
//

struct Itemz: Codable, Equatable {
    var kind: String
    var volumeCount: Int
}

struct Items: Codable, Equatable {
    var items: [Book]
}

struct Book: Codable, Equatable, Identifiable {
    var id: String
    var volumeInfo: VolumeInfo
//    var genre: String
//    var image: String
//    var status: String
    
    mutating func setAsUnavailable() {
//        status = "Unavailable"
    }
    
    var title: String {
        volumeInfo.title
    }
    
    var author: String {
        guard let authors = volumeInfo.authors else {
            return "Unknown author"
        }
        
        return String(authors.joined(separator: ", "))
    }
    
    var year: String {
        volumeInfo.publishedDate
    }
    
    var image: String {
        volumeInfo.imageLinks.thumbnail
    }
}
    
struct VolumeInfo: Codable, Equatable {
    var title: String
    var authors: [String]?
    var publishedDate: String
    var imageLinks: ImageLinks
}

struct ImageLinks: Codable, Equatable {
    var thumbnail: String
}

//struct Book: Codable, Equatable, Identifiable {
//    var id: Int
//    var author: String
//    var title: String
//    var genre: String
//    var year: String
//    var image: String
//    var status: String
//
//    mutating func setAsUnavailable() {
//        status = "Unavailable"
//    }
//}
