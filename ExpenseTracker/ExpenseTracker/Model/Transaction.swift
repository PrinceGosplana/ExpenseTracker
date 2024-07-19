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

/// Sample transactions for ui building
var sampleTransactions: [Transaction] = [
    .init(title: "Magic Keyboard", remarks: "Apple Product", amount: 129, dateAdded: .now, category: .expense, tintColor: tints.randomElement()!),
    .init(title: "Apple Musuc", remarks: "Subscription", amount: 10.99, dateAdded: .now, category: .expense, tintColor: tints.randomElement()!),
    .init(title: "iCloud", remarks: "Subscription", amount: 0.99, dateAdded: .now, category: .expense, tintColor: tints.randomElement()!),
    .init(title: "Payment", remarks: "Payment Received!", amount: 2000, dateAdded: .now, category: .income, tintColor: tints.randomElement()!),
]
