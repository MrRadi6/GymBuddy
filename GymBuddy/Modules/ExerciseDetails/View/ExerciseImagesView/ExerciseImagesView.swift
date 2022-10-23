//
//  ExerciseImagesView.swift
//  GymBuddy
//
//  Created by Samir on 10/23/22.
//

import SwiftUI

struct ExerciseImagesView: View {
    private let imageCornerRadius: CGFloat = 5
    let images: [ExerciseImageItem]

    init(images: [String]) {
        self.images = images.map { ExerciseImageItem(url: $0) }
    }

    var body: some View {
        ScrollView(SwiftUI.Axis.Set.horizontal, showsIndicators: false) {
            HStack(alignment: .center,spacing: 5) {
                ForEach(images) { image in
                    ImageView(imageURL: image.url, placeholder: .workoutPlaceholder)
                        .frame(width: 150, height: 150)
                        .clipShape(RoundedRectangle(cornerRadius: imageCornerRadius))
                }
            }
        }
    }
}
