
// MARK: - Model

class JangoFett {
    
    // MARK: Public properties
    
    let firstName = "Jango"
    let lastName = "Fett"
    var health = 100.0
    
    // MARK: Private properties
    
    private let strength: Float = 80.0
    private let agility: Float = 60.0
    private let intelligence: Float = 85.0
    
    // MARK: Public method
    
    func attack() -> Float {
        return (strength + agility) / 2.0
    }
    
    func dodge() -> Float {
        return (intelligence + agility) / 2.0
    }
    
}

// MARK: - Result

let jangoFett = JangoFett()
let attack = jangoFett.attack()
let dodge = jangoFett.dodge()

let clone = jangoFett

clone.health -= 10.0

print("Clone health => \(clone.health)")
print("jangoFett health => \(jangoFett.health)")
