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
}

enum OpenAICreateSpeechModel: String, Encodable {
    case tts1 = "tts-1"
    case tts1HD = "tts-1-hd"
}

enum OpenAICreateSpeechVoice: String, Encodable {
    case alloy
    case echo
    case fable
    case onyx
    case nova
    case shimmer
}
