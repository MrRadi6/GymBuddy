//
//  ImageView.swift
//  GymBuddy
//
//  Created by Samir on 10/23/22.
//

import SwiftUI
import Kingfisher

struct ImageView: View {
    let imageURL: String?
    let placeholder: UIImage?
    
    var body: some View {
        if let imageURL {
            KFImage.url(URL(string: imageURL))
                .onFailureImage(placeholder)
                .processingQueue(.dispatch(.global()))
                .cacheMemoryOnly()
                .fade(duration: 0.3)
                .cacheMemoryOnly()
                .resizable()
        } else if let placeholder {
            Image(uiImage: placeholder)
                .resizable()
        }
    }
}
