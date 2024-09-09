//
//  ViewModel.swift
//  SpeechSynthOpenAI
//
//  Created by Robert Harrison on 9/9/24.
//

import Foundation
import AVFoundation

enum SpeechSynthStatus: String {
    case ready
    case loading
    case playing
}

final class ViewModel: NSObject, ObservableObject {
    @Published var synthStatus: SpeechSynthStatus = .ready

    private let openAIService = OpenAIService()
    private var audioPlayer: AVAudioPlayer?

    override init() {
        super.init()
    }

    func synthesizeSpeech(from text: String) {
        guard case .ready = synthStatus else { return }
        synthStatus = .loading

        Task { [weak self] in
            guard let self else { return }

            do {
                let speechURL = try await openAIService.synthesizeSpeech(from: text)
                print(speechURL.absoluteString)

                try await MainActor.run { [weak self] in
                    guard let self else { return }

                    // The file downloaded has a ".tmp" file extension. Set file type hint to "mp3", so that it can be played.
                    audioPlayer = try AVAudioPlayer(contentsOf: speechURL, fileTypeHint: "mp3")
                    audioPlayer?.delegate = self
                    audioPlayer?.prepareToPlay()

                    synthStatus = .playing

                    audioPlayer?.play()
                }
            } catch {
                print(error)

                await MainActor.run { [weak self] in
                    guard let self else { return }
                    synthStatus = .ready
                }
            }
        }
    }
}

extension ViewModel: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        Task { @MainActor [weak self] in
            self?.synthStatus = .ready
        }
    }
}
