//
//  OpenAIModels.swift
//  SpeechSynthOpenAI
//
//  Created by Robert Harrison on 9/9/24.
//

import Foundation

struct OpenAICreateSpeechBody: Encodable {
    let model: OpenAICreateSpeechModel
    let input: String
    let voice: OpenAICreateSpeechVoice
    let responseFormat: OpenAICreateSpeechResponseFormat?
    let speed: Double?

    enum CodingKeys: String, CodingKey {
        case model
        case input
        case voice
        case responseFormat = "response_format"
        case speed
    }
}

enum OpenAICreateSpeechModel: String, CaseIterable, Encodable {
    case tts1 = "tts-1"
    case tts1HD = "tts-1-hd"
}

enum OpenAICreateSpeechVoice: String, CaseIterable, Encodable {
    case alloy
    case echo
    case fable
    case onyx
    case nova
    case shimmer
}

enum OpenAICreateSpeechResponseFormat: String, Encodable {
    case mp3
    case opus
    case aac
    case flac
    case wav
    case pcm
}
