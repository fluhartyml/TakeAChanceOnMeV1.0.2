//
//  ContentView.swift
//  TakeAChanceOnMe
//
//  Random number generator with gradient background
//

import SwiftUI

struct ContentView: View {
    @State private var maxNumber: Int = 100
    @State private var generatedNumber: Int?
    @State private var inputText: String = "100"
    @FocusState private var isInputFocused: Bool
    
    var body: some View {
        ZStack {
            // Gradient background
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
                isInputFocused = false
            }
            
            VStack(spacing: 40) {
                // Title
                Text("Take A Chance On Me")
                    .font(.system(size: 32, weight: .medium))
                    .foregroundColor(.white)
                    .padding(.top, 60)
                
                Spacer()
                
                // Generated number display
                if let number = generatedNumber {
                    Text(formatNumber(number))
                        .font(.system(size: 120, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .minimumScaleFactor(0.01)
                        .lineLimit(1)
                } else {
                    Text("?")
                        .font(.system(size: 120, weight: .bold, design: .rounded))
                        .foregroundColor(.white.opacity(0.5))
                }
                
                Spacer()
                
                // Input section
                VStack(spacing: 16) {
                    Text("Maximum Number")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                    
                    TextField("", text: $inputText)
                        .font(.system(size: 28, weight: .medium))
                        .foregroundColor(.black)
                        .padding()
                        .background(Color(white: 0.75))
                        .cornerRadius(12)
                        .keyboardType(.numberPad)
                        .focused($isInputFocused)
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard) {
                                Spacer()
                                Button("Done") {
                                    isInputFocused = false
                                }
                            }
                        }
                        .onChange(of: inputText) { newValue in
                            // Only allow positive integers up to 100
                            let filtered = newValue.filter { $0.isNumber }
                            if filtered != newValue {
                                inputText = filtered
                            }

                            if let number = Int(filtered), number >= 1 {
                                if number > 100 {
                                    maxNumber = 100
                                    inputText = "100"
                                } else {
                                    maxNumber = number
                                }
                            } else if filtered.isEmpty {
                                maxNumber = 1
                            }
                        }
                    
                    Text("Range: 1 to \(formatNumber(maxNumber))")
                        .font(.system(size: 18))
                        .foregroundColor(.white.opacity(0.8))
                }
                .padding(.horizontal, 40)
                
                // Generate button
                Button(action: generateNumber) {
                    Text("Generate")
                        .font(.system(size: 28, weight: .medium))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.white, lineWidth: 3)
                        )
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 40)
            }
        }
    }
    
    private func generateNumber() {
        // Dismiss keyboard when generating
        isInputFocused = false
        
        guard maxNumber >= 1 else {
            generatedNumber = nil
            return
        }
        
        // Generate from 1 to maxNumber (inclusive)
        generatedNumber = Int.random(in: 1...maxNumber)
    }
    
    private func formatNumber(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        return formatter.string(from: NSNumber(value: number)) ?? "\(number)"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
