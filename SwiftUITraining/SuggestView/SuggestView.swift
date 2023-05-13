//
//  SuggestView.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 19/02/2021.
//

import SwiftUI

struct SuggestView: View {
    @State private var suggestionResponseIsPresented = false
    @StateObject private var suggestViewModel = SuggestViewModel()
    @EnvironmentObject var vm: UserStateViewModel
    
    @State private var showSheet = false
    /*
     didSet does not work with State properties, we must use the onChange modifier to listen to stream changes
     https://www.hackingwithswift.com/quick-start/swiftui/how-to-run-some-code-when-state-changes-using-onchange
     */
    @State private var bookImage = UIImage()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        UploadImageView(bookImage: bookImage)
                            .onTapGesture {
                              showSheet = true
                            }
                        Spacer()
                    }
                    HStack {
                        Text("An image must be provided")
                            .font(.footnote)
                            .foregroundColor(.charcoal)
                        Spacer()
                    }
                    .padding(.bottom)
                    SuggestFormFieldsView(suggestViewModel: suggestViewModel)
                }
                .padding(20)
                
                CapsuleButton(buttonTitle: "SUBMIT",
                              enabled: $suggestViewModel.isSubmitEnabled) {
                    suggestionResponseIsPresented = true
                    bookImage = UIImage()
                    suggestViewModel.clearForm()
                }
            }
            .navigationTitle("SUGGEST BOOK")
            .toolbar {
                LogoutButton(buttonAction: vm.signOut)
            }
            .background(Color.white.cornerRadius(5).shadow(radius: 2))
            .padding(20)
            .background(Color.lavender)
            .alert(isPresented: $suggestionResponseIsPresented, content: {
                Alert(title: Text("Work in progress"),
                      message: Text("There is no Google Books API endpoint for suggesting a new book"),
                      dismissButton: .default(Text("Ok")))
            })
            .sheet(isPresented: $showSheet) {
                // Pick an image from the photo library:
                ImagePicker(sourceType: .photoLibrary,
                            selectedImage: $bookImage)
            }
            /*
             For some reason onChange gets triggered after clearForm, even though the empty image was set before
             We only call imageAssigned when a nonEmpty image is set then
             */
            .onChange(of: bookImage) { newImage in
                if newImage.isNotEmpty {
                    suggestViewModel.imageAssigned()
                }
            }
        }
    }
}

struct SuggestView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = UserStateViewModel.getMock(loggedIn: true)
        
        SuggestView()
            .environmentObject(vm)
    }
}
