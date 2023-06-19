//
//  Color.swift
//  EIT-Remote
//
//  Created by Danil Peregorodiev on 19.12.2022.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let secondaryText = Color("SecondaryTextColor")
}
