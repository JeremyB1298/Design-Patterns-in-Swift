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
        let restroomStatus = hasRestroom ? "with restroom" : "without restroom"
        let restaurantStatus = hasRestaurant ? "and with restaurant." : "and without restaurant."
        let frontConnection = frontConnectionId.map { "\nConnected to the back of n°\($0)," } ?? "\nIt's the first wagon,"
        let backConnection = backConnectionId.map { " connected to the front of n°\($0)" } ?? "it's the last wagon."
        
        return "Wagon n°\(id), \(name). Has the capacity of \(capacity) persons, \(restroomStatus) \(restaurantStatus)\(frontConnection)\(backConnection)"
    }
}

// MARK: Train

struct Train: CustomStringConvertible {
    var id: Int
    var name: String
    var wagons: [Wagon]
    
    var description: String {
        return "The train \(name) has \(wagons.count) wagons.\n" + wagons.map { $0.description }.joined(separator: ",\n")
    }
}

// MARK: - Builders

// MARK: WagonBuilder

protocol WagonBuilder {
    func buildWagon(id: Int, name: String, capacity: Int, hasRestroom: Bool, hasRestaurant: Bool, frontConnectionId: Int?, backConnectionId: Int?) -> Wagon
    func reset()
}

// MARK: WagonBuilderImpl

final class WagonBuilderImpl: WagonBuilder {
    
    // MARK: Private property
    
    private var currentWagon: Wagon?
    
    // MARK: Public methods
    
    func buildWagon(id: Int, name: String, capacity: Int, hasRestroom: Bool, hasRestaurant: Bool, frontConnectionId: Int?, backConnectionId: Int?) -> Wagon {
        currentWagon = Wagon(id: id, name: name, capacity: capacity, hasRestroom: hasRestroom, hasRestaurant: hasRestaurant, frontConnectionId: frontConnectionId, backConnectionId: backConnectionId)
        return currentWagon!
    }
    
    func reset() {
        currentWagon = nil
    }
}

// MARK: TrainBuilder

protocol TrainBuilder {
    func buildTrain(id: Int, name: String, wagons: [Wagon]) -> Train
    func reset()
}

// MARK: TrainBuilderImpl

final class TrainBuilderImpl: TrainBuilder {
    
    // MARK: Private property
    
    private var currentTrain: Train?
    
    // MARK: Public methods
    
    func buildTrain(id: Int, name: String, wagons: [Wagon]) -> Train {
        currentTrain = Train(id: id, name: name, wagons: wagons)
        return currentTrain!
    }
    
    func reset() {
        currentTrain = nil
    }
}

// MARK: - Directors

struct WagonDirector {
    
    // MARK: WagonType
    
    enum WagonType {
        case locomotive
        case secondClass
        case firstClass
        case restaurant
    }
    
    // MARK:  Private property
    
    private let builder: WagonBuilder
    
    // MARK: Initializer
    
    init(builder: WagonBuilder) {
        self.builder = builder
    }
    
    // MARK: Public method
    
    func buildWagon(type: WagonType, id: Int) -> Wagon {
        switch type {
        case .locomotive:
            return builder.buildWagon(id: id, name: "Locomotive 🚂", capacity: 2, hasRestroom: false, hasRestaurant: false, frontConnectionId: nil, backConnectionId: nil)
        case .secondClass:
            return builder.buildWagon(id: id, name: "Second class wagon 🙂", capacity: 18, hasRestroom: true, hasRestaurant: false, frontConnectionId: nil, backConnectionId: nil)
        case .firstClass:
            return builder.buildWagon(id: id, name: "First class wagon 🤑", capacity: 10, hasRestroom: false, hasRestaurant: false, frontConnectionId: nil, backConnectionId: nil)
        case .restaurant:
            return builder.buildWagon(id: id, name: "Restaurant wagon 🍕", capacity: 4, hasRestroom: false, hasRestaurant: true, frontConnectionId: nil, backConnectionId: nil)
        }
    }
}

// MARK: TrainDirector

struct TrainDirector {
    
    // MARK: Private properties
    
    private let builder: TrainBuilder
    private let wagonDirector: WagonDirector
    
    // MARK: Initializer
    
    init(builder: TrainBuilder, wagonDirector: WagonDirector) {
        self.builder = builder
        self.wagonDirector = wagonDirector
    }
    
    // MARK: Public method
    
    func buildClassicTrain(id: Int) -> Train {
        builder.reset()
        
        var locomotive = wagonDirector.buildWagon(type: .locomotive, id: 0)
        var secondClassWagon = wagonDirector.buildWagon(type: .secondClass, id: 1)
        var restaurantWagon = wagonDirector.buildWagon(type: .restaurant, id: 2)
        var firstClassWagon = wagonDirector.buildWagon(type: .firstClass, id: 3)
        
        locomotive.backConnectionId = secondClassWagon.id
        secondClassWagon.frontConnectionId = locomotive.id
        secondClassWagon.backConnectionId = restaurantWagon.id
        restaurantWagon.frontConnectionId = secondClassWagon.id
        restaurantWagon.backConnectionId = firstClassWagon.id
        firstClassWagon.frontConnectionId = restaurantWagon.id
        
        return builder.buildTrain(id: id, name: "Classic train step 6", wagons: [locomotive, secondClassWagon, restaurantWagon, firstClassWagon])
    }
}

// MARK: - Result

let wagonBuilder = WagonBuilderImpl()
let wagonDirector = WagonDirector(builder: wagonBuilder)

let trainBuilder = TrainBuilderImpl()
let trainDirector = TrainDirector(builder: trainBuilder, wagonDirector: wagonDirector)

let classicTrain = trainDirector.buildClassicTrain(id: 0)

print(classicTrain)
