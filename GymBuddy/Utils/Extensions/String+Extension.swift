//
//  String+Extension.swift
//  GymBuddy
//
//  Created by Samir on 10/20/22.
//

import Foundation

extension String {
    var localized: String { return NSLocalizedString(self, comment: "") }
    var capitalizedFirstLetter: String {
        return prefix(1).capitalized + self.dropFirst()
    }
}
