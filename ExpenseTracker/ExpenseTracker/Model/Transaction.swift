//
//  Transaction.swift
//  ExpenseTracker
//
//  Created by Oleksandr Isaiev on 17.07.2024.
//

import SwiftUI

struct Transaction: Identifiable {
    let id = UUID()
    let title: String
    let remarks: String
    let amount: Double
    let dateAdded: Date
    let category: String
    let tintColor: String

    init(title: String, remarks: String, amount: Double, dateAdded: Date, category: Category , tintColor: TintColor ) {
        self.title = title
        self.remarks = remarks
        self.amount = amount
        self.dateAdded = dateAdded
        self.category = category.rawValue
        self.tintColor = tintColor.color
    }

    var color: Color {
        tints.first(where: { $0.color == tintColor })?.value ?? .accent
    }

}
