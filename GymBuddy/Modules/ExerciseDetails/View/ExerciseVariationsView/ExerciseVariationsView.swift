//
//  ExerciseVariationsView.swift
//  GymBuddy
//
//  Created by Samir on 10/23/22.
//

import SwiftUI

struct ExerciseVariationsView: View {
    let variations: [ExerciseVariationItem]

    init(variations: [Exercise]) {
        self.variations = variations.map { ExerciseVariationItem(exercise: $0) }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            ForEach(variations) { variation in
                NavigationLink {
                    ExerciseDetailsNavigator.createModule(with: variation.exerciseId)
                } label: {
                    Text(variation.name)
                        .font(.headline)
                }
            }
        }
    }
}
