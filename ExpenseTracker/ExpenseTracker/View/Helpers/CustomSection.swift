//
//  CustomSection.swift
//  ExpenseTracker
//
//  Created by Oleksandr Isaiev on 23.07.2024.
//

import SwiftUI

struct CustomSection: View {
    let title: String
    let hint: String
    @Binding var value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.gray)
                .hSpacing(.leading)

            TextField(hint, text: $value)
                .padding(.horizontal, 15)
                .padding(.vertical, 12)
                .background(.background, in: .rect(cornerRadius: 10))
        }
    }
}

#Preview {
    CustomSection(title: "Title", hint: "Hint", value: .constant("Value"))
}
