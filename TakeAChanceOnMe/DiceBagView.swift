//
//  DiceBagView.swift
//  TakeAChanceOnMe
//
//  7-slot dice bag with persistent max values and results
//

import SwiftUI

struct DiceBagView: View {
    // Persistent max values (survive app close) — 0 means empty/not set
    @AppStorage("die0Max") private var die0Max: Int = 0
    @AppStorage("die1Max") private var die1Max: Int = 0
    @AppStorage("die2Max") private var die2Max: Int = 0
    @AppStorage("die3Max") private var die3Max: Int = 0
    @AppStorage("die4Max") private var die4Max: Int = 0
    @AppStorage("die5Max") private var die5Max: Int = 0
    @AppStorage("die6Max") private var die6Max: Int = 0

    // Persistent results (survive app close, 0 = "?")
    @AppStorage("die0Result") private var die0Result: Int = 0
    @AppStorage("die1Result") private var die1Result: Int = 0
    @AppStorage("die2Result") private var die2Result: Int = 0
    @AppStorage("die3Result") private var die3Result: Int = 0
    @AppStorage("die4Result") private var die4Result: Int = 0
    @AppStorage("die5Result") private var die5Result: Int = 0
    @AppStorage("die6Result") private var die6Result: Int = 0

    // Toggles (reset each launch)
    @State private var toggles: [Bool] = Array(repeating: true, count: 7)

    // Text field strings for max inputs
    @State private var maxTexts: [String] = []

    @FocusState private var focusedField: Int?

    var body: some View {
        ZStack {
            // Same gradient as Tab 1
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.6, green: 0.7, blue: 1.0),
                    Color(red: 0.8, green: 0.6, blue: 1.0)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            .onTapGesture {
                focusedField = nil
            }

            VStack(spacing: 10) {
                Text("Dice Bag")
                    .font(.system(size: 28, weight: .medium))
                    .foregroundColor(.white)
                    .padding(.top, 20)

                // Column headers
                HStack(spacing: 0) {
                    Text("Roll")
                        .frame(width: 60)
                    Text("Result")
                        .frame(maxWidth: .infinity)
                    Text("Max")
                        .frame(width: 80)
                }
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.white.opacity(0.7))
                .padding(.horizontal, 30)

                ScrollView {
                    VStack(spacing: 6) {
                        ForEach(0..<7, id: \.self) { index in
                            dieRow(index: index)
                        }
                    }
                    .padding(.horizontal, 30)
                }
                .scrollDismissesKeyboard(.interactively)

                Spacer()

                // Generate button
                Button(action: generate) {
                    Text("Generate")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.white, lineWidth: 3)
                        )
                }
                .padding(.horizontal, 40)

                // Clear Results button
                Button(action: clearResults) {
                    Text("Clear Results")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.white.opacity(0.7))
                }
                .padding(.bottom, 20)
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    focusedField = nil
                }
            }
        }
        .onAppear {
            // Initialize text fields from persisted values (0 shows as empty)
            maxTexts = [die0Max, die1Max, die2Max, die3Max, die4Max, die5Max, die6Max]
                .map { $0 == 0 ? "" : "\($0)" }
        }
    }

    @ViewBuilder
    private func dieRow(index: Int) -> some View {
        HStack(spacing: 12) {
            // Toggle
            Toggle("", isOn: $toggles[index])
                .labelsHidden()
                .frame(width: 50)

            // Result
            Text(getResult(index) == 0 ? "?" : "\(getResult(index))")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(getResult(index) == 0 ? .white.opacity(0.5) : .white)
                .frame(maxWidth: .infinity)

            // Max input
            TextField("", text: maxTextBinding(index))
                .font(.system(size: 22, weight: .medium))
                .foregroundColor(.black)
                .frame(width: 70)
                .padding(8)
                .background(Color(white: 0.75))
                .cornerRadius(8)
                .keyboardType(.numberPad)
                .focused($focusedField, equals: index)
                .multilineTextAlignment(.center)
                .onChange(of: getMaxText(index)) { newValue in
                    let filtered = newValue.filter { $0.isNumber }
                    if filtered != newValue {
                        setMaxText(index, filtered)
                    }
                    if let number = Int(filtered), number >= 1, number <= 100 {
                        setMax(index, number)
                    } else if filtered.isEmpty {
                        setMax(index, 0)
                    } else if let number = Int(filtered), number > 100 {
                        setMax(index, 100)
                        setMaxText(index, "100")
                    }
                }
        }
        .padding(.vertical, 2)
    }

    // MARK: - Actions

    private func generate() {
        focusedField = nil
        for i in 0..<7 {
            if toggles[i] && getMax(i) > 0 {
                let result = Int.random(in: 1...getMax(i))
                setResult(i, result)
            }
        }
    }

    private func clearResults() {
        for i in 0..<7 {
            setResult(i, 0)
        }
    }

    // MARK: - Storage Accessors

    private func getResult(_ index: Int) -> Int {
        switch index {
        case 0: return die0Result
        case 1: return die1Result
        case 2: return die2Result
        case 3: return die3Result
        case 4: return die4Result
        case 5: return die5Result
        case 6: return die6Result
        default: return 0
        }
    }

    private func setResult(_ index: Int, _ value: Int) {
        switch index {
        case 0: die0Result = value
        case 1: die1Result = value
        case 2: die2Result = value
        case 3: die3Result = value
        case 4: die4Result = value
        case 5: die5Result = value
        case 6: die6Result = value
        default: break
        }
    }

    private func getMax(_ index: Int) -> Int {
        switch index {
        case 0: return die0Max
        case 1: return die1Max
        case 2: return die2Max
        case 3: return die3Max
        case 4: return die4Max
        case 5: return die5Max
        case 6: return die6Max
        default: return 6
        }
    }

    private func setMax(_ index: Int, _ value: Int) {
        switch index {
        case 0: die0Max = value
        case 1: die1Max = value
        case 2: die2Max = value
        case 3: die3Max = value
        case 4: die4Max = value
        case 5: die5Max = value
        case 6: die6Max = value
        default: break
        }
    }

    private func getMaxText(_ index: Int) -> String {
        guard index < maxTexts.count else { return "6" }
        return maxTexts[index]
    }

    private func setMaxText(_ index: Int, _ value: String) {
        guard index < maxTexts.count else { return }
        maxTexts[index] = value
    }

    private func maxTextBinding(_ index: Int) -> Binding<String> {
        Binding(
            get: { getMaxText(index) },
            set: { setMaxText(index, $0) }
        )
    }
}

#Preview {
    DiceBagView()
}
