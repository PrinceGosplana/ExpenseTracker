//
//  ChartModel.swift
//  ExpenseTracker
//
//  Created by Oleksandr Isaiev on 27.07.2024.
//

import SwiftUI

/// Model is used to represent a graph that will show each month's total transactions based on categories
struct ChartGroup: Identifiable {
    let id = UUID()
    var date: Date
    var categories: [ChartCategory]
    var totalIncome: Double
    var totalExpense: Double
}

struct ChartCategory: Identifiable {
    let id = UUID()
    var totalValue: Double
    var category: Category
}
