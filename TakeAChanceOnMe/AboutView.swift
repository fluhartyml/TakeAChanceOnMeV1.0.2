//
//  AboutView.swift
//  TakeAChanceOnMe
//
//  Created by Michael Fluharty on 4/6/26.
//

import SwiftUI
import MessageUI

struct AboutView: View {
    @State private var showingFeedback = false

    private let accentPurple = Color(red: 0.7, green: 0.5, blue: 1.0)
    private let bgDark = Color(red: 0.15, green: 0.12, blue: 0.25)
    private let textDim = Color(red: 0.6, green: 0.55, blue: 0.75)

    private var version: String {
        let v = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "?"
        let b = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "?"
        return "v\(v) (\(b))"
    }

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.6, green: 0.7, blue: 1.0),
                    Color(red: 0.8, green: 0.6, blue: 1.0)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {
                    VStack(spacing: 8) {
                        Image(systemName: "die.face.6.fill")
                            .font(.system(size: 60))
                            .foregroundStyle(.white)

                        Text("TakeAChanceOnMe")
                            .font(.system(size: 24, weight: .bold, design: .monospaced))
                            .foregroundStyle(.white)

                        Text(version)
                            .font(.system(size: 18, design: .monospaced))
                            .foregroundStyle(.white.opacity(0.7))

                        Text("Pick a number, take a chance.")
                            .font(.system(size: 18, design: .monospaced))
                            .foregroundStyle(.white.opacity(0.6))
                    }
                    .padding(.top, 40)

                    VStack(spacing: 12) {
                        aboutRow("Michael Lee Fluharty", icon: "person.fill")
                        aboutRow("Engineered with Claude by Anthropic", icon: "cpu")
                        Divider().overlay(.white.opacity(0.2))
                        aboutRow("CC BY-SA 4.0", icon: "doc.text.fill")
                    }
                    .padding(16)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                    Button {
                        showingFeedback = true
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: "envelope.fill")
                                .font(.system(size: 18))
                            Text("Send Feedback")
                                .font(.system(size: 18, weight: .semibold, design: .monospaced))
                        }
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(accentPurple)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .sheet(isPresented: $showingFeedback) {
                        FeedbackView(appName: "TakeAChanceOnMe")
                    }
                }
                .padding(20)
            }
        }
    }

    private func aboutRow(_ text: String, icon: String) -> some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 18))
                .foregroundStyle(.white.opacity(0.6))
            Text(text)
                .font(.system(size: 18, design: .monospaced))
                .foregroundStyle(.white.opacity(0.8))
            Spacer()
        }
    }
}
