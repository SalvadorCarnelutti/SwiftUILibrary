//
//  Book.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 15/10/2020.
//

struct Items: Codable, Equatable {
    var items: [Book]
}

struct Book: Codable, Equatable, Identifiable {
    var id: String
    var volumeInfo: VolumeInfo
    
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
        String(volumeInfo.publishedDate.prefix(4))
    }
    
    var pageCount: String {
        "\(volumeInfo.pageCount) pages"
    }
    
    var image: String {
        volumeInfo.imageLinks.thumbnail
    }
}
    
struct VolumeInfo: Codable, Equatable {
    var title: String
    var authors: [String]?
    var publishedDate: String
    var pageCount: Int
    var imageLinks: ImageLinks
}

struct ImageLinks: Codable, Equatable {
    var thumbnail: String
}
