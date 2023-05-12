//
//  RemoteImage.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 25/02/2021.
//

import SwiftUI

struct RemoteImage: View {
    private enum LoadState {
        case loading, success, failure
    }

    private class Loader: ObservableObject {
        var data = Data()
        var state = LoadState.loading

        init(url: String) {
            
            guard let parsedHTTPURL = URL(string: url), var comps = URLComponents(url: parsedHTTPURL, resolvingAgainstBaseURL: false) else {
                self.state = .failure
                return
            }
            
            comps.scheme = "https"
            guard let parsedHTTPSURL = comps.url else { return }

            URLSession.shared.dataTask(with: parsedHTTPSURL) { data, response, error in
                if let data = data, data.count > 0 {
                    self.data = data
                    self.state = .success
                } else {
                    self.state = .failure
                }

                DispatchQueue.main.async {
                    self.objectWillChange.send()
                }
            }.resume()
        }
    }

    @StateObject private var loader: Loader
    var loading: Image
    var failure: Image

    var body: some View {
        selectImage()
            .resizable()
    }

    init(url: String, loading: Image = Image(systemName: "photo"),
         failure: Image = Image(systemName: "multiply.circle")) {
        _loader = StateObject(wrappedValue: Loader(url: url))
        self.loading = loading
        self.failure = failure
    }

    private func selectImage() -> Image {
        switch loader.state {
        case .loading:
            return loading
        case .failure:
            return failure
        default:
            if let image = UIImage(data: loader.data) {
                return Image(uiImage: image)
            } else {
                return failure
            }
        }
    }
}

struct RemoteImage_Previews: PreviewProvider {
    static var previews: some View {
        RemoteImage(url: "https://images-na.ssl-images-amazon.com/images/I/51egIZUl88L._SX336_BO1,204,203,200_.jpg")
            .frame(width: 200, height: 300, alignment: .center)
            .aspectRatio(contentMode: .fit)
    }
}
