//
//  Transaction.swift
//  ExpenseTracker
//
//  Created by Oleksandr Isaiev on 17.07.2024.
//

import SwiftData
import SwiftUI

@Model
class Transaction {
    var title: String
    var remarks: String
    var amount: Double
    var dateAdded: Date
    var category: String
    var tintColor: String

    init(title: String, remarks: String, amount: Double, dateAdded: Date, category: Category , tintColor: TintColor ) {
        self.title = title
        self.remarks = remarks
        self.amount = amount
        self.dateAdded = dateAdded
        self.category = category.rawValue
        self.tintColor = tintColor.color
    }

    @Transient
    var color: Color {
        tints.first(where: { $0.color == tintColor })?.value ?? .red
    }

    @Transient
    var tint: TintColor? {
        tints.first(where: { $0.color == tintColor })
    }

    @Transient
    var rawCategory: Category? {
        Category.allCases.first(where: { category == $0.rawValue })
    }
}
