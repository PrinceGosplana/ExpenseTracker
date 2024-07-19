//
//  ActionBuilder.swift
//  CoffeTime
//
//  Created by Oleksandr Isaiev on 05.07.2024.
//

import SwiftUI

/// Just like ViewBuilder, we can use result builders in Swift to build a result by combining multiple expessions into a single one using the 'build block'
@resultBuilder
struct ActionBuilder {
    static func buildBlock(_ components: Action...) -> [Action] {
        return components
    }
}
