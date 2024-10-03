// MARK: - Model

struct Music {
    func play() {
        print("Play music 🎶")
    }
}

// MARK: - App

struct MusicApp {
    
    // MARK: Private property
    
    private let music: Music
    
    // MARK: Initializer
    
    init() {
        music = Music()
    }
    
    // MARK: Public method
    
    func startMusic() {
        music.play()
    }
}

// MARK: - Result

let musicApp = MusicApp()
musicApp.startMusic()
