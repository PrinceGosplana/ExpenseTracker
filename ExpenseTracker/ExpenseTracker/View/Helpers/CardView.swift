//
//  CardView.swift
//  ExpenseTracker
//
//  Created by Oleksandr Isaiev on 19.07.2024.
//

import SwiftUI

struct CardView: View {

    let income: Double
    let expense: Double

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(.background)

            VStack(spacing: 0) {
                HStack(spacing: 12) {
                    Text("")
                }
            }
        }
    }
}

#Preview {
    CardView(income: 250, expense: 110)
}
