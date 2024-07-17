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
}
