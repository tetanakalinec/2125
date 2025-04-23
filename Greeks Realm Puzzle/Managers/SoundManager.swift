import AVFoundation
import SwiftUI

protocol SoundManagerProtocol {
    func setupNotifications()
    func toggleMusic(_ value: Bool?)
    func setupBackgroundMusic(name: String)
}

final class SoundManager: ObservableObject {
    
    static let shared = SoundManager()
    
    @AppStorage("isMusicEnabled") var isMusicEnabled = true
    
    var backgroundMusicPlayer: AVAudioPlayer?
    
    private init() {
        setupBackgroundMusic(name: "olimp")
        setupNotifications()
    }
    
    func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(pauseMusic), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resumeMusic), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    @objc func pauseMusic() {
        backgroundMusicPlayer?.pause()
    }
    
    @objc func resumeMusic() {
        if isMusicEnabled {
            backgroundMusicPlayer?.play()
        }
    }
    
    func toggleMusic(_ value: Bool? = nil) {
        if let value = value {
            isMusicEnabled = value
        } else {
            isMusicEnabled.toggle()
        }
        
        if isMusicEnabled {
            backgroundMusicPlayer?.play()
        } else {
            backgroundMusicPlayer?.pause()
        }
    }
    
    func setupBackgroundMusic(name: String = "olimp") {
        if let musicPath = Bundle.main.path(forResource: name, ofType: "mp3") {
            let url = URL(fileURLWithPath: musicPath)
            
            do {
                backgroundMusicPlayer = try AVAudioPlayer(contentsOf: url)
                guard isMusicEnabled else { return }
                backgroundMusicPlayer?.numberOfLoops = -1
                backgroundMusicPlayer?.play()
            } catch {
                print("Error initializing background music: \(error)")
            }
        }
    }
}
