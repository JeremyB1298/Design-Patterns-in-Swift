
// MARK: - Models

protocol Music {
    func play()
}

struct RockMusic: Music {
    
    func play() {
        print("Play rock music 🎸")
    }
    
}

struct ClassicMusic: Music {
    
    func play() {
        print("Play classic music 🎻")
    }
    
}

struct PopMusic: Music {
    
    func play() {
        print("Play classic music 🎤")
    }
    
}

// MARK: - Music Factory

struct MusicFactory {
    
    // MARK: Public method
    
    func createMusic(type: MusicType) -> Music {
        switch type {
        case .rock:
            return RockMusic()
        case .classic:
            return ClassicMusic()
        case .pop:
            return PopMusic()
        }
    }
}

// MARK: - MusicType Enum

enum MusicType {
    case rock
    case classic
    case pop
}

// MARK: - App

struct MusicApp {
    
    // MARK: Private property
    
    private let music: Music
    
    // MARK: - Initializer
    
    init(factory: MusicFactory, musicType: MusicType) {
        music = factory.createMusic(type: musicType)
    }
    
    // MARK: - Public method
    
    func startMusic() {
        music.play()
    }
}

// MARK: - Result

let musicFactory = MusicFactory()
let musicApp = MusicApp(factory: musicFactory, musicType: .classic)
musicApp.startMusic()

