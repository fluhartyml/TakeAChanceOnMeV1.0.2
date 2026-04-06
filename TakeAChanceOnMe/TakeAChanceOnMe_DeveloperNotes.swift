//
//  TakeAChanceOnMe_DeveloperNotes.swift
//  TakeAChanceOnMe
//
//  Developer Notes — Persistent Memory for AI Assistants
//  Created: 2026 MAR 18 (Claude Code)
//

// ============================================================================
// MARK: - PROJECT IDENTITY
// ============================================================================
//
//  Name:           TakeAChanceOnMe
//  Bundle ID:      com.inkwell.TakeAChanceOnMe
//  Platform:       iOS (iPhone + iPad)
//  Version:        2.0
//  Apple ID:       6753626820
//  Language:       Swift, SwiftUI
//  GitHub:         fluhartyml/TakeAChanceOnMeV1.0.2
//  Location:       /Users/michaelfluharty/Developer/TakeAChanceOnMeV1.0.2/
//  App Store:      US + Canada only

// ============================================================================
// MARK: - DESCRIPTION
// ============================================================================
//
//  Random number generator with gradient background.
//  User enters a maximum number, app generates a random number between
//  1 and that number. Simple, clean, intuitive.
//
//  Features:
//    - Number pad input with "Done" toolbar button
//    - Tap-to-dismiss keyboard
//    - Gradient purple/blue background
//    - Large formatted number display with commas
//    - Range display: "Range: 1 to [number]"
//    - DiceBagView (v2.0 feature)

// ============================================================================
// MARK: - FILE STRUCTURE
// ============================================================================
//
//  TakeAChanceOnMe/
//    TakeAChanceOnMeApp.swift  — App entry point
//    ContentView.swift         — Main number generator view
//    DiceBagView.swift         — Dice bag feature (v2.0)

// ============================================================================
// MARK: - VERSION HISTORY
// ============================================================================
//
//  v1.0.0 — Initial release. Range: 0 to max.
//  v1.0.1 — Published to App Store.
//  v1.0.2 — Fixed keyboard dead-end bug (Generate button not actionable when
//           keyboard covered it on smaller iPhones). Changed range from
//           0-max to 1-max ("0 is a conceptual number, a placeholder with
//           no value"). Added keyboard dismissal (tap anywhere + Done button).
//           Reduced App Store availability from 175 countries to US + Canada.
//           Bug reported → fixed → submitted in under 12 hours.
//  v2.0   — Added DiceBagView feature.

// ============================================================================
// MARK: - ABOUT THIS APP
// ============================================================================
//
//  TakeAChanceOnMe
//  Version 2.0
//
//  Pick a number, take a chance.
//
//  Engineered with Claude by Anthropic
//
//  Copyright (c) 2025 Michael Fluharty
//  Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//  https://creativecommons.org/licenses/by-sa/4.0/
//
//  You are free to share and adapt this work under the following terms:
//  - Attribution: Give appropriate credit, provide a link to the license
//  - ShareAlike: Distribute contributions under the same license
//
//  Website: https://fluharty.me
//  Contact: michael@fluharty.me
//  Feedback and suggestions welcome!

// ============================================================================
// MARK: - DEVELOPER NOTES LOG
// ============================================================================
//
//  2026 MAR 18 — Developer notes file created with version history,
//                About This App section, and CC BY-SA 4.0 license. (Claude Code)
//
