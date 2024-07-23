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
                TransactionCardView(
                    transaction: .init(
                        title: title.isEmpty ? "Title" : remarks,
                        remarks: remarks.isEmpty ? "Remarks" : remarks,
                        amount: amount,
                        dateAdded: dateAdded,
                        category: category,
                        tintColor: tint
                    )
                )

                CustomSection(title: "Title", hint: "Magic Keyboard", value: $title)

                CustomSection(title: "Remarks", hint: "Apple Product!", value: $remarks)

                /// Amount $ Category check box
                VStack(alignment: .leading, spacing: 10) {
                    Text("Amount & Category")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .hSpacing(.leading)

                    HStack(spacing: 15) {
                        TextField("0.0", value: $amount, formatter: numberFormatter)
                            .padding(.horizontal, 15)
                            .padding(.vertical, 12)
                            .background(.background, in: .rect(cornerRadius: 10))
                            .frame(maxWidth: 130)
                            .keyboardType(.decimalPad)
                    }
                }
            }
            .padding(15)
        }
        .navigationTitle("Add Transaction")
        .background(.gray.opacity(0.15))
    }

    /// Number formatter
    var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2

        return formatter
    }
}

#Preview {
    NavigationStack {
        NewExpenseView()
    }
}
