//
//  CategoryCheckBox.swift
//  ExpenseTracker
//
//  Created by Oleksandr Isaiev on 25.07.2024.
//

import SwiftUI

struct CategoryCheckBox: View {

    @Binding var category: Category

    var body: some View {
        HStack(spacing: 10) {
            ForEach(Category.allCases, id:\.self) { category in
                HStack(spacing: 5) {
                    ZStack {
                        Image(systemName: "circle")
                            .font(.title3)
                            .foregroundStyle(.accent)

                        if self.category == category {
                            Image(systemName: "circle.fill")
                                .font(.caption)
                                .foregroundStyle(.accent)
                        }
                    }

                    Text(category.rawValue)
                        .font(.caption)
                }
                .contentShape(.rect)
                .onTapGesture {
                    self.category = category
                }
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 12)
        .hSpacing(.leading)
        .background(.background, in: .rect(cornerRadius: 10))
    }
}

#Preview {
    CategoryCheckBox(category: .constant(.expense))
}
