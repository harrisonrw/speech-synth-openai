//
//  SpeechSynthOpenAIApp.swift
//  SpeechSynthOpenAI
//
//  Created by Robert Harrison on 9/9/24.
//

import SwiftUI

@main
struct SpeechSynthOpenAIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ViewModel())
        }
    }
}
