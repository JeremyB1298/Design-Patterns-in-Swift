
// MARK: - Models

protocol Warrior {
    var firstName: String { get }
    var lastName: String { get }
    var health: Float { get set }
    
    func attack() -> Float
    func dodge() -> Float
    func copy(firstName: String, lastName: String) -> Warrior
}

class Trooper: Warrior {
    
    // MARK: Public properties
    
    let firstName: String
    let lastName: String
    var health: Float
    
    // MARK: Private properties
    
    private let strength: Float
    private let agility: Float
    private let intelligence: Float
    
    // MARK: Initializer
    
    init(
        firstName: String,
        lastName: String,
        health: Float,
        strength: Float,
        agility: Float,
        intelligence: Float
    ) {
        self.firstName = firstName
        self.lastName = lastName
        self.health = health
        self.strength = strength
        self.agility = agility
        self.intelligence = intelligence
    }
    
    // MARK: Public method
    
    func attack() -> Float {
        return (strength + agility) / 2.0
    }
    
    func dodge() -> Float {
        return (intelligence + agility) / 2.0
    }
    
    func copy(firstName: String, lastName: String) -> Warrior {
        
        let strength = strength * 0.9
        let agility = agility * 0.9
        let intelligence = intelligence * 0.9
        
        return Trooper(
            firstName: firstName,
            lastName: lastName,
            health: health,
            strength: strength,
            agility: agility,
            intelligence: intelligence
        )
    }
}

// MARK: - Result

let jangoFett = Trooper(firstName: "Jango", lastName: "Fett", health: 100.0, strength: 80.0, agility: 60.0, intelligence: 85.0)
var clone = jangoFett.copy(firstName: "Michael", lastName: "Shooter")

clone.health -= 10.0

print("Clone health => \(clone.health)")
print("jangoFett health => \(jangoFett.health)")
