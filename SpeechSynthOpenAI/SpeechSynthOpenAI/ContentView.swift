//
//  ContentView.swift
//  SpeechSynthOpenAI
//
//  Created by Robert Harrison on 9/9/24.
//

import SwiftUI

extension View {
    func navigationBarTitleColor(_ color: Color) -> some View {
        let uiColor = UIColor(color)
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: uiColor]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: uiColor]
        return self
    }
}

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    @State private var inputText = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Input text") {
                    TextEditor(text: $inputText)
                        .scrollContentBackground(.hidden)
                        .foregroundStyle(.white)
                        .tint(Color.blue)
                        .frame(height: 100)

                }
                .listRowBackground(Color.gray.opacity(0.2))

                Section("Options") {
                    Picker("Model", selection: $viewModel.selectedModel) {
                        ForEach(OpenAICreateSpeechModel.allCases, id: \.self) { model in
                            Text(model.rawValue)
                        }
                    }

                    Picker("Voice", selection: $viewModel.selectedVoice) {
                        ForEach(OpenAICreateSpeechVoice.allCases, id: \.self) { voice in
                            Text(voice.rawValue)
                        }
                    }

                    // TODO: add Format

                    // TODO: add Speed
                }
                .listRowBackground(Color.gray.opacity(0.2))

                Section {
                    Text("Status: \(viewModel.synthStatus)")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.white)

                    Button {
                        viewModel.synthesizeSpeech(from: inputText)
                    } label: {
                        Text("Synthesize")
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.white)
                            .bold()
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(16)

                    }
                    .disabled(viewModel.synthStatus != .ready)
                }
                .listRowBackground(Color.black)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .foregroundColor(.white) // Section Header color.
            .background(.black)
            .navigationTitle("Speech Synthesizer")
            .navigationBarTitleColor(.white)
            .tint(Color.blue)
        }
    }
}

#Preview {
    ContentView(viewModel: ViewModel())
}
