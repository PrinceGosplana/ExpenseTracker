//
//  LockView.swift
//  CoffeTime
//
//  Created by Oleksandr Isaiev on 21.07.2024.
//

import SwiftUI
import LocalAuthentication

struct LockView<Content: View>: View {
    /// Lock Properties
    let lockType: LockType
    let lockPin: String
    let isEnabled: Bool
    let maxLimit = 4
    var lockWhenAppGoesBackground: Bool = true
    @State private var pin: String = ""
    @State private var isUnlocked: Bool = false
    @State private var noBiometricAccess: Bool = false
    @State private var animateField: Bool = false
    /// Lock context
    let context = LAContext()
    /// Scene phase
    @Environment(\.scenePhase) private var phase

    var forgotPin: () -> () = { }
    @ViewBuilder let content: Content
    
    var body: some View {
        GeometryReader {
            let size = $0.size

            content
                .frame(width: size.width, height: size.height)

            if isEnabled && !isUnlocked {

                ZStack {
                    Rectangle()
                        .fill(.black)
                        .ignoresSafeArea()
                    if (lockType == .both && !noBiometricAccess) || lockType == .biometric {
                        Group {
                            if noBiometricAccess {
                                Text("Enable biometric authentication in Settings to unlock the view.")
                                    .font(.callout)
                                    .multilineTextAlignment(.center)
                                    .padding(50)
                            } else {
                                /// Bio metric / pin unlock
                                VStack(spacing: 12) {
                                    VStack(spacing: 6) {
                                        Image(systemName: "lock")
                                            .font(.largeTitle)

                                        Text("Tap to Unlock")
                                            .font(.caption2)
                                            .foregroundStyle(.gray)
                                    }
                                    .frame(width: 100, height: 100)
                                    .background(.ultraThinMaterial, in: .rect(cornerRadius: 10))
                                    .contentShape(.rect)
                                    .onTapGesture {
                                        unlockView()
                                    }

                                    if lockType == .both {
                                        Text("Enter Pin")
                                            .frame(width: 100, height: 40)
                                            .background(.ultraThinMaterial, in: .rect(cornerRadius: 10))
                                            .contentShape(.rect)
                                            .onTapGesture {
                                                noBiometricAccess = true
                                            }
                                    }
                                }
                            }
                        }
                    } else {
                        /// Custom number pad to type view lock pin
                        NumberPadPin()
                    }
                }
                .environment(\.colorScheme, .dark)
                .transition(.offset(y: size.height + 100))
            }
        }
        .onChange(of: isEnabled, initial: true) { oldValue, newValue in
            if newValue { unlockView() }
        }
        /// Locking when the app goes background
        .onChange(of: phase) { oldValue, newValue in
            if newValue != .active && lockWhenAppGoesBackground {
                isUnlocked = false
                pin = ""
            }

            if newValue == .active && !isUnlocked && isEnabled {
                unlockView()
            }
        }
    }

    private func unlockView() {
        /// Checking and unlocking view
        Task {
            if isBiometricAvailable && lockType != .number {
                /// Requesting biometric unlock
                if let result = try? await context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Unlock the View"), result {
                    withAnimation(.snappy, completionCriteria: .logicallyComplete) {
                        isUnlocked = true
                    } completion: {
                        pin = ""
                    }
                }
            }

            /// No bio Metric permission || Lock type must be set as keypad updating biometric status
            noBiometricAccess = !isBiometricAvailable
        }
    }

    private var isBiometricAvailable: Bool {
        context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
    }

    /// Lock Type
    enum LockType: String {
        case biometric = "Bio Metric Auth"
        case number = "Custom Number Lock"
        case both = "First preference will be biometric, and if it's not available, it will go for number lock"
    }

    @ViewBuilder
    private func NumberPadPin() -> some View {
            VStack(spacing: 15) {
                Text("Enter Pin")
                    .font(.title.bold())
                    .frame(maxWidth: .infinity)
                    .overlay(alignment: .leading) {
                        /// back button only for both lock type
                        if lockType == .both && isBiometricAvailable {
                            Button {
                                pin = ""
                                noBiometricAccess = false
                            } label: {
                                Image(systemName: "arrow.left")
                                    .font(.title3)
                                    .contentShape(.rect)
                            }
                            .tint(.white)
                            .padding(.leading)
                        }
                    }

                /// adding wiggling animation for wrong password with keyframe animation
                HStack(spacing: 10) {
                    ForEach(0..<4, id:\.self) { index in
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 50, height: 55)
                        /// Showing Pin at each box with the help of index
                            .overlay {
                                /// Safe check
                                if pin.count > index {
                                    let index = pin.index(pin.startIndex, offsetBy: index)
                                    let string = String(pin[index])

                                    Text(string)
                                        .font(.title.bold())
                                        .foregroundStyle(.black)
                                }
                            }
                    }
                }
                .keyframeAnimator(initialValue: CGFloat.zero, trigger: animateField, content: { content, value in
                    content
                        .offset(x: value)
                }, keyframes: { _ in
                    CubicKeyframe(30, duration: 0.07)
                    CubicKeyframe(-30, duration: 0.07)
                    CubicKeyframe(20, duration: 0.07)
                    CubicKeyframe(-20, duration: 0.07)
                    CubicKeyframe(0, duration: 0.07)
                })
                .padding(.top, 15)
                .overlay(alignment: .bottomTrailing) {
                    Button("Forgot Pin?") {
                        forgotPin()
                    }
                    .foregroundStyle(.white)
                    .offset(y: 40)
                }
                .frame(maxHeight: .infinity)

                /// Custom number pad
                GeometryReader { _ in
                    LazyVGrid(columns: Array(repeating: GridItem(), count: 3), content: {
                        ForEach(1...9, id:\.self) { number in
                            Button {
                                /// Adding number to pin
                                /// Max limit - 4
                                if pin.count < maxLimit {
                                    pin.append("\(number)")
                                }
                            } label: {
                                Text("\(number)")
                                    .font(.title)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 20)
                                    .contentShape(.rect)
                            }
                            .tint(.white)
                        }

                        Button {
                            if !pin.isEmpty {
                                pin.removeLast()
                            }
                        } label: {
                            Image(systemName: "delete.backward")
                                .font(.title)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 20)
                                .contentShape(.rect)
                        }
                        .tint(.white)

                        Button {
                            if pin.count <= maxLimit {
                                pin.append("0")
                            }
                        } label: {
                            Text("0")
                                .font(.title)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 20)
                                .contentShape(.rect)
                        }
                        .tint(.white)

                    })
                    .frame(maxHeight: .infinity, alignment: .bottom)
                }
                .onChange(of: pin) { oldValue, newValue in
                    if newValue.count == maxLimit {
                        /// Validate pin
                        if lockPin == pin {
                            withAnimation(.snappy, completionCriteria: .logicallyComplete) {
                                isUnlocked = true
                            } completion: {
                                /// clearing pin
                                pin = ""
                                noBiometricAccess = !isBiometricAvailable
                            }
                        } else {
                            pin = ""
                            animateField.toggle()
                        }
                    }
                }

            }
            .padding()
            .environment(\.colorScheme, .dark)
    }
}

#Preview {
    ContentView()
}
