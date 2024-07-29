//
//  TransactionView.swift
//  ExpenseTracker
//
//  Created by Oleksandr Isaiev on 23.07.2024.
//

import SwiftUI

struct TransactionView: View {
    /// Env Properties
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    var editTransaction: Transaction?
    
    @State private var title = ""
    @State private var remarks = ""
    @State private var amount: Double = .zero
    @State private var dateAdded: Date = .now
    @State private var category: Category = .expense
    /// Random Tint
    @State var tint: TintColor = tints.randomElement()!

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
                        HStack(spacing: 4) {
                            Text(currencySymbol)
                                .font(.callout.bold())
                            TextField("0.0", value: $amount, formatter: numberFormatter)
                                .keyboardType(.decimalPad)
                        }
                        .padding(.horizontal, 15)
                        .padding(.vertical, 12)
                        .background(.background, in: .rect(cornerRadius: 10))
                        .frame(maxWidth: 130)

                        /// Custom check box
                        CategoryCheckBox(category: $category)
                    }
                }

                VStack(alignment: .leading, spacing: 10) {
                    Text("Date")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .hSpacing(.leading)

                    DatePicker("", selection: $dateAdded, displayedComponents: [.date])
                        .datePickerStyle(.graphical)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 12)
                        .background(.background, in: .rect(cornerRadius: 10))
                }
            }
            .padding(15)
        }
        .navigationTitle("\(editTransaction == nil ? "Add" : "Edit") Transaction")
        .background(.gray.opacity(0.15))
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") { save() }
            }
        }
        /// Loading all the data from the existing transaction into the necessary text fields and pickers
        .onAppear {
            if let editTransaction {
                title = editTransaction.title
                remarks = editTransaction.remarks
                dateAdded = editTransaction.dateAdded
                if let category = editTransaction.rawCategory {
                    self.category = category
                }
                amount = editTransaction.amount
                if let tint = editTransaction.tint {
                    self.tint = tint
                }
            }
        }
    }

    private func save() {
        if editTransaction != nil {
            editTransaction?.title = title
            editTransaction?.remarks = remarks
            editTransaction?.amount = amount
            editTransaction?.category = category.rawValue
            editTransaction?.dateAdded = dateAdded
        } else {
            /// Saving Item to SwiftData
            let transaction = Transaction(
                title: title,
                remarks: remarks,
                amount: amount,
                dateAdded: dateAdded,
                category: category,
                tintColor: tint
            )

            context.insert(transaction)
        }

        dismiss()
    }

    /// Number formatter
    private var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2

        return formatter
    }
}

#Preview {
    NavigationStack {
        TransactionView()
    }
}
