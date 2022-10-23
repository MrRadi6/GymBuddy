//
//  ExerciseDetailsView.swift
//  GymBuddy
//
//  Created by Samir on 10/23/22.
//

import SwiftUI
import Kingfisher

struct ExerciseDetailsView: View {
    @StateObject var viewModel: ExerciseDetailsViewModel
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                if let title = viewModel.exerciseDetails?.name {
                    ExerciseTitleView(title: title)
                        .padding()
                }
                if let images = viewModel.exerciseDetails?.images, !images.isEmpty {
                    ExerciseImagesView(images: images)
                        .padding()
                }
                if let variations = viewModel.exerciseDetails?.variations, !variations.isEmpty {
                    ExerciseVariationsView(variations: variations)
                        .padding()
                }
                Spacer()
            }
            if viewModel.isLoading {
                LoadingView(isLoading: $viewModel.isLoading)
            }
        }
//        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.loadExerciseDetails()
        }
    }
}

// MARK: - exercise title view
private struct ExerciseTitleView: View {
    let title: String

    var body: some View {
        HStack {
            Text(title)
                .font(.title)
            Spacer()
        }
    }
}
