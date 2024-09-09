//
//  OpenAIService.swift
//  SpeechSynthOpenAI
//
//  Created by Robert Harrison on 9/9/24.
//

import Foundation

final class OpenAIService {
    private let createSpeechEndpoint = "https://api.openai.com/v1/audio/speech"

    func synthesizeSpeech(from text: String) async throws -> URL {
        let url = URL(string: createSpeechEndpoint)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        request.setValue("Bearer \(APIKeys.openAI)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = OpenAICreateSpeechBody(model: .tts1, input: text, voice: .alloy)
        request.httpBody = try JSONEncoder().encode(body)

        let session = URLSession(configuration: .default)

        let result = try await session.download(for: request)

        return result.0
    }
}
