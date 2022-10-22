//
//  ExerciseTableViewCell.swift
//  GymBuddy
//
//  Created by Samir on 10/22/22.
//

import UIKit
import Kingfisher

class ExerciseTableViewCell: UITableViewCell {

    @IBOutlet weak private var exerciseImageView: UIImageView!
    @IBOutlet weak private var exerciseNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    func bind(with info: ExerciseCellInfo) {
        exerciseNameLabel.text = info.name
        setExerciseImage(with: info.image)
    }

    private func setExerciseImage(with imageUrl: String?) {
        guard let imageUrl else {
            exerciseImageView.image = .workoutPlaceholder
            return
        }
        let url = URL(string: imageUrl)
        exerciseImageView.kf.setImage(with: url, placeholder: UIImage.workoutPlaceholder)
    }
}
