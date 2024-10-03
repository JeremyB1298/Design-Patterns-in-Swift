// MARK: - Models

struct ClassicMusic {
    func play() {
        print("Play classic music 🎻")
    }
}

struct RockMusic {
    func play() {
        print("Play rock music 🎸")
    }
}

// MARK: - App

struct MusicApp {
    
    // MARK: Config
    
    enum MusicType {
        case classic
        case rock
    }
    
    // MARK: Private properties
    
    private let musicType: MusicType
    private var rockMusic: RockMusic?
    private var classicMusic: ClassicMusic?
    
    // MARK: Initializer
    
    init(musicType: MusicType) {
        self.musicType = musicType
        
        switch musicType {
        case .classic:
            classicMusic = ClassicMusic()
        case .rock:
            rockMusic = RockMusic()
        }
    }
    
    // MARK: Public method
    
    func startMusic() {
        switch musicType {
        case .classic:
            classicMusic?.play()
        case .rock:
            rockMusic?.play()
        }
    }
}

// MARK: - Result

let musicApp = MusicApp(musicType: .rock)
musicApp.startMusic()
