//
//  TakeAChanceOnMeApp.swift
//  TakeAChanceOnMe
//
//  Main app entry point
//

import SwiftUI

@main
struct TakeAChanceOnMeApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView()
                    .tabItem {
                        Label("Take A Chance", systemImage: "die.face.6.fill")
                    }

                DiceBagView()
                    .tabItem {
                        Label("Dice Bag", systemImage: "bag.fill")
                    }
            }
        }
    }
}
