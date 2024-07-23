//
//  NewExpenseView.swift
//  ExpenseTracker
//
//  Created by Oleksandr Isaiev on 23.07.2024.
//

import SwiftUI

struct NewExpenseView: View {
    @State private var title = ""
    @State private var remarks = ""
    @State private var amount: Double = .zero
    @State private var dateAdded: Date = .now
    @State private var category: Category = .expense
    /// Random Tint
    var tint: TintColor = tints.randomElement()!

    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 15) {
                Text("Preview")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .hSpacing(.leading)

                /// Preview transaction card view
            }
            .padding(15)
        }
        .navigationTitle("Add Transaction")
    }
}

#Preview {
    NavigationStack {
        NewExpenseView()
    }
}
