//
//  PointView.swift
//  ExpenseTracker
//
//  Created by Oleksandr Isaiev on 16.07.2024.
//

import SwiftUI

struct PointView: View {

    let symbol: String
    let title: String
    let subTitle: String

    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: symbol)
                .font(.largeTitle)
                .foregroundStyle(.blue.gradient)
                .frame(width: 45)

            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)

                Text(subTitle)
                    .foregroundStyle(.gray)
            }
        }
    }
}

#Preview {
    PointView(symbol: "dollarsign", title: "Test", subTitle: "Test subTitle")
}
