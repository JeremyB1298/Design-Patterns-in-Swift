import Foundation

// MARK: - Models

// MARK: Wagon

struct Wagon: CustomStringConvertible {
    let id: Int
    let name: String
    let capacity: Int
    let hasRestroom: Bool
    let hasRestaurant: Bool
    var frontConnectionId: Int?
    var backConnectionId: Int?
    
    var description: String {
        "Wagon n°\(id), \(name). Has the capacity of \(capacity) persons,"
        + (hasRestroom ? " with restroom" : " without restroom")
        + (hasRestaurant ? " and with restaurant." : " and without restaurant.")
        + (frontConnectionId != nil ? "\nConnected to the back of n°\(frontConnectionId!), " : "\nIt's the first wagon, ")
        + (backConnectionId != nil ? " connected to the front of n°\(backConnectionId!)" : "it's the last wagon")
    }
}

// MARK: Train

struct Train: CustomStringConvertible {
    var name: String
    var wagons: [Wagon]
    
    var description: String {
        "The train \(name) has \(wagons.count) wagonds.\n"
        +
        wagons.map({ $0.description }).joined(separator: ",\n")
    }
}

// MARK: - Builder

protocol WagonBuilder {
    func setName(name: String)
    func setId(id: Int)
    func setCapacity(capacity: Int)
    func setRestroom(hasRestroom: Bool)
    func setRestaurant(hasRestaurant: Bool)
    func setFrontConnectionId(id: Int?)
    func setBackConnectionId(id: Int?)
    func build() -> Wagon
    func reset()
}

final class WagonBuilderImpl: WagonBuilder {
    
    // MARK: Private properties
    
    private var id: Int = 0
    private var name: String = ""
    private var capacity: Int = 0
    private var hasRestroom: Bool = false
    private var hasRestaurant: Bool = false
    private var frontConnectionId: Int? = nil
    private var backConnectionId: Int? = nil
    
    // MARK: Public methods
    
    func setName(name: String) {
        self.name = name
    }
    
    func setId(id: Int) {
        self.id = id
    }
    
    func setCapacity(capacity: Int) {
        self.capacity = capacity
    }
    
    func setRestroom(hasRestroom: Bool) {
        self.hasRestroom = hasRestroom
    }
    
    func setRestaurant(hasRestaurant: Bool) {
        self.hasRestaurant = hasRestaurant
    }
    
    func setFrontConnectionId(id: Int?) {
        frontConnectionId = id
    }
    
    func setBackConnectionId(id: Int?) {
        backConnectionId = id
    }
    
    func build() -> Wagon {
        Wagon(
            id: id,
            name: name,
            capacity: capacity,
            hasRestroom: hasRestroom,
            hasRestaurant: hasRestaurant,
            frontConnectionId: frontConnectionId,
            backConnectionId: backConnectionId
        )
    }
    
    func reset() {
        id = 0
        name = ""
        capacity = 0
        hasRestroom = false
        hasRestaurant = false
        frontConnectionId = nil
        backConnectionId = nil
    }
    
}

// MARK: - WagonDirector

struct WagonDirector {
    
    // MARK: Private property
    
    private let builder: WagonBuilder
    
    // MARK: Initializer
    
    init(builder: WagonBuilder) {
        self.builder = builder
    }
    
    // MARK: Public methods
    
    func buildLocomotive(id: Int) -> Wagon {
        builder.reset()
        
        builder.setId(id: id)
        builder.setName(name: "Locomotive 🚂")
        builder.setCapacity(capacity: 2)
        builder.setRestroom(hasRestroom: false)
        builder.setRestaurant(hasRestaurant: false)
        
        return builder.build()
    }
    
    func buildSecondClassWagon(with id: Int) -> Wagon {
        builder.reset()
        
        builder.setId(id: id)
        builder.setName(name: "Second class wagon 🙂")
        builder.setCapacity(capacity: 18)
        builder.setRestroom(hasRestroom: true)
        builder.setRestaurant(hasRestaurant: false)
        
        return builder.build()
    }
    
    func buildFirstClassWagon(with id: Int) -> Wagon {
        builder.reset()
        
        builder.setId(id: id)
        builder.setName(name: "First class wagon 🤑")
        builder.setCapacity(capacity: 10)
        builder.setRestroom(hasRestroom: false)
        builder.setRestaurant(hasRestaurant: false)
        
        return builder.build()
    }
    
    func buildRestaurantWagon(with id: Int) -> Wagon {
        builder.reset()
        
        builder.setId(id: id)
        builder.setName(name: "Restaurant wagon 🍕")
        builder.setCapacity(capacity: 4)
        builder.setRestroom(hasRestroom: false)
        builder.setRestaurant(hasRestaurant: true)
        
        return builder.build()
    }
    
}

// MARK: - Result

let builder = WagonBuilderImpl()
let director = WagonDirector(builder: builder)

var locomotive = director.buildLocomotive(id: 0)
var secondClassWagon = director.buildSecondClassWagon(with: 1)
var firstClassWagon = director.buildFirstClassWagon(with: 2)
var restaurantWagon = director.buildRestaurantWagon(with: 3)

locomotive.backConnectionId = secondClassWagon.id

secondClassWagon.frontConnectionId = locomotive.id
secondClassWagon.backConnectionId = firstClassWagon.id

firstClassWagon.frontConnectionId = secondClassWagon.id
firstClassWagon.backConnectionId = restaurantWagon.id

restaurantWagon.frontConnectionId = firstClassWagon.id

let train = Train(
    name: "My Train 🚃 Step 4",
    wagons: [
        locomotive,
        secondClassWagon,
        firstClassWagon,
        restaurantWagon
    ]
)

print(train)
