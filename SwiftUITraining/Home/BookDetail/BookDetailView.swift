//
//  SwiftUIView.swift
//  SwiftUITraining
//
//  Created by Diego Quiros on 02/11/2020.
//

import SwiftUI

struct BookDetailView: View {
    @State private var unavailableIsPresented = false
    @StateObject var bookDetailViewModel: BookDetailViewModel
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Image("img_book6")
                        .resizable()
                        .frame(width: 70, height: 105)
                        
                    VStack(alignment: .leading) {
                        Text(bookDetailViewModel.getBookTitle)
                            .font(.title2)
                            .fixedSize(horizontal: false, vertical: true)
                            .lineLimit(nil)
                        Text(bookDetailViewModel.getBookStatus.uppercased())
                            .font(.headline)
                            .foregroundColor(statusColor)
                        Text(bookDetailViewModel.getBookAuthor)
                            .foregroundColor(Color.charcoal)
                            .fixedSize(horizontal: false, vertical: true)
                            .lineLimit(nil)
                        Text(bookDetailViewModel.getBookYear)
                            .foregroundColor(Color.charcoal)
                        Text(bookDetailViewModel.getBookGenre)
                            .foregroundColor(Color.charcoal)
                    }
                    .padding(.leading, 20)
                    Spacer()
                }
                Button(action: {
                    bookDetailViewModel.postBookWish()
                }) {
                    Text("ADD TO WISHLIST").font(.headline).foregroundColor(Color.deepSkyBlue)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .clipShape(Capsule())
                .overlay(Capsule().stroke(Color.deepSkyBlue, lineWidth: 2))
                .padding(.vertical, 12)
                Button(action: {
                    if bookDetailViewModel.bookIsAvailable {
                        bookDetailViewModel.postBookRent()
                    } else {
                        unavailableIsPresented.toggle()
                    }
                }) {
                    Text("RENT").font(.headline).foregroundColor(Color.white)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(rentButtonColor)
                .clipShape(Capsule())
                
            }
            .padding()
            .background(Color.white.cornerRadius(5).shadow(radius: 2))
            .padding()
            ScrollView {
                LazyVStack {
                    ForEach(bookDetailViewModel.bookComments.suffix(5)) { bookComment in
                        VStack(alignment: .leading) {
                            HStack {
                                VStack {
                                    Image("img_user1")
                                        .padding(5)
                                    Spacer()
                                }
                                VStack {
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text(bookComment.user.username)
                                            .font(.headline)
                                        Text(bookComment.content)
                                    }
                                    .padding(.bottom, 20)
                                    Divider()
                                    if bookDetailViewModel.isLastBookComment(bookComment) {
                                        Text("View All")
                                            .foregroundColor(Color.deepSkyBlue)
                                            .padding(5)
                                    }
                                }
                            }
                        }
                    }
                }
                .padding()
            }
            .background(Color.white.cornerRadius(5).shadow(radius: 2))
            .padding(.horizontal)
        }
        .background(Color.lavender)
        .navigationBarTitle(Text(bookDetailViewModel.getBookTitle), displayMode: .inline)
        .edgesIgnoringSafeArea(.bottom)
        .alert(isPresented: $unavailableIsPresented, content: {
            Alert(title: Text("Sorry, this curent book is unavailable at the moment"),
                  message: Text("Try again later"),
                  dismissButton: .default(Text("Ok")))
        })
        .listStyle(GroupedListStyle())
        .onAppear {
            bookDetailViewModel.getBookComments()
        }
    }
    
    var statusColor: Color {
        return bookDetailViewModel.bookIsAvailable ? Color.atlantis : Color.venetianRed
    }
    
     var rentButtonColor: LinearGradient {
        let availableGradient = LinearGradient(gradient: Gradient(colors: [Color.deepSkyBlue, Color.mediumTurquoise]),
                                               startPoint: .leading, endPoint: .trailing)
        let unavailableGradient = LinearGradient(gradient: Gradient(colors: [Color.gainsboro]),
                                                 startPoint: .leading, endPoint: .trailing)
        return bookDetailViewModel.bookIsAvailable ? availableGradient : unavailableGradient
     }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BookDetailView(bookDetailViewModel: BookDetailViewModel.getMockedViewModel())
        }
    }
}
