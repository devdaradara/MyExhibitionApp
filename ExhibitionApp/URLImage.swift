//
//  URLImage.swift
//  ExhibitionApp
//
//  Created by 류지예 on 2023/02/21.
//
import SwiftUI
import Combine

struct URLImage: View {
    @StateObject private var imageLoader = URLImageLoader()

    private let urlString: String?

    init(urlString: String?) {
        self.urlString = urlString
    }

    var body: some View {
        content
            .onAppear {
                imageLoader.fetch(urlString: urlString)
            }
    }

    private var content: some View {
        Group {
            let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
    }
}
