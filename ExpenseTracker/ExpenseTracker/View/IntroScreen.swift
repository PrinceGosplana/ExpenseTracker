//
//  IntroScreen.swift
//  ExpenseTracker
//
//  Created by Oleksandr Isaiev on 16.07.2024.
//

import SwiftUI

struct IntroScreen: View {
    /// Visibility status
    @AppStorage("isFirstTime") private var isFirstTime: Bool = true

    var body: some View {
        VStack(spacing: 15) {
            Text("What's New in the\nExpense Tracker")
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)
                .padding(.top, 65)
                .padding(.bottom, 35)

            VStack(alignment: .leading, spacing: 25) {
                PointView(
                    symbol: "dollarsign",
                    title: "Transactions",
                    subTitle: "Keep track of your earnings and expenses"
                )

                PointView(
                    symbol: "chart.bar.fill",
                    title: "Visual Charts",
                    subTitle: "View your transactions using eye-catching graphic representations"
                )

                PointView(
                    symbol: "magnifyingglass",
                    title: "Advance Filters",
                    subTitle: "Find the expenses you want by advance search and filtering"
                )
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 25)

            Spacer(minLength: 10)

            Button {
                isFirstTime = false
            } label: {
                Text("Continue")
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(.accent.gradient, in: .rect(cornerRadius: 12))
                    .contentShape(.rect)
            }
        }
        .padding(15)
    }
}

#Preview {
    IntroScreen()
}
