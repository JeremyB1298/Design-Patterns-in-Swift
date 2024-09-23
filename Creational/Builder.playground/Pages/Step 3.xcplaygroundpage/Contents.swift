import Foundation

// MARK: - Models

// MARK: - Wagon

struct Wagon: CustomStringConvertible {
    let id: Int
    let name: String
    let capacity: Int
    let hasRestroom: Bool
    let hasRestaurant: Bool
    var frontConnectionId: Int?
    var backConnectionId: Int?
    
    var description: String {
        "Wagon n°\(id), \(name). It has the capacity of \(capacity) persons,"
        + (hasRestroom ? " with restroom" : " without restroom")
        + (hasRestaurant ? " and with restaurant." : " and without restaurant.")
        + (frontConnectionId != nil ? "\nConnected to the back of n°\(frontConnectionId!), " : "\nIt's the first wagon, ")
        + (backConnectionId != nil ? " connected to the front of n°\(backConnectionId!)" : "it's the last wagon")
    }
}

// MARK: - Train

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

protocol Builder {
    func buildClassicTrain() -> Train
    func buildGoldTraint() -> Train
    func buildFastestTrain() -> Train
}

struct BuilderImpl: Builder {
    
    func buildClassicTrain() -> Train {

        var locomotive = Wagon(
            id: 0,
            name: "Locomotive 🚂",
            capacity: 2,
            hasRestroom: false,
            hasRestaurant: false
        )

        var secondClassWagon = Wagon(
            id: 1,
            name: "Second class wagon 🙂",
            capacity: 18,
            hasRestroom: true,
            hasRestaurant: false
        )

        var firstClassWagon = Wagon(
            id: 2,
            name: "First class wagon 🤑",
            capacity: 10,
            hasRestroom: false,
            hasRestaurant: false
        )

        var restaurantWagon = Wagon(
            id: 3,
            name:  "Restaurant wagon 🍕",
            capacity: 4,
            hasRestroom: false,
            hasRestaurant: true
        )

        locomotive.backConnectionId = secondClassWagon.id

        secondClassWagon.frontConnectionId = locomotive.id
        secondClassWagon.backConnectionId = firstClassWagon.id

        firstClassWagon.frontConnectionId = secondClassWagon.id
        firstClassWagon.backConnectionId = restaurantWagon.id

        restaurantWagon.frontConnectionId = firstClassWagon.id

        let train = Train(
            name: "My classic train 🚃 step 3",
            wagons: [
                locomotive,
                secondClassWagon,
                firstClassWagon,
                restaurantWagon
            ]
        )
        
        return train
    }
    
    func buildGoldTraint() -> Train {
        var locomotive = Wagon(
            id: 0,
            name: "Locomotive 🚂",
            capacity: 2,
            hasRestroom: false,
            hasRestaurant: false
        )

        var firstClassWagon1 = Wagon(
            id: 2,
            name: "First class wagon 🤑",
            capacity: 10,
            hasRestroom: false,
            hasRestaurant: false
        )

        var firstClassWagon2 = Wagon(
            id: 3,
            name: "First class wagon 🤑",
            capacity: 10,
            hasRestroom: false,
            hasRestaurant: false
        )

        var firstClassWagon3 = Wagon(
            id: 4,
            name: "First class wagon 🤑",
            capacity: 10,
            hasRestroom: false,
            hasRestaurant: false
        )

        locomotive.backConnectionId = firstClassWagon1.id
        
        firstClassWagon1.frontConnectionId = locomotive.id
        firstClassWagon1.backConnectionId = firstClassWagon2.id
        
        firstClassWagon2.frontConnectionId = firstClassWagon1.id
        firstClassWagon2.backConnectionId = firstClassWagon3.id
        
        firstClassWagon3.frontConnectionId = firstClassWagon2.id

        let train = Train(
            name: "My Glod Train 🚃 step 3",
            wagons: [
                locomotive,
                firstClassWagon1,
                firstClassWagon2,
                firstClassWagon3
            ]
        )
        
        return train
    }
    
    func buildFastestTrain() -> Train {
        var locomotive1 = Wagon(
            id: 0,
            name: "Locomotive 🚂",
            capacity: 2,
            hasRestroom: false,
            hasRestaurant: false
        )
        
        var locomotive2 = Wagon(
            id: 1,
            name: "Locomotive 🚂",
            capacity: 2,
            hasRestroom: false,
            hasRestaurant: false
        )
        
        var locomotive3 = Wagon(
            id: 2,
            name: "Locomotive 🚂",
            capacity: 2,
            hasRestroom: false,
            hasRestaurant: false
        )
        
        var locomotive4 = Wagon(
            id: 3,
            name: "Locomotive 🚂",
            capacity: 2,
            hasRestroom: false,
            hasRestaurant: false
        )
        
        locomotive1.backConnectionId = locomotive2.id
        
        locomotive2.frontConnectionId = locomotive1.id
        locomotive2.backConnectionId = locomotive3.id
        
        locomotive3.frontConnectionId = locomotive2.id
        locomotive3.backConnectionId = locomotive4.id
        
        locomotive4.frontConnectionId = locomotive3.id

        let train = Train(
            name: "My Fastest Train 🚃 step 3",
            wagons: [
                locomotive1,
                locomotive2,
                locomotive3,
                locomotive4
            ]
        )
        
        return train
    }
    
}

// MARK: - Result

let builder = BuilderImpl()

let classicTrain = builder.buildClassicTrain()
let goldTrain = builder.buildGoldTraint()
let fastestTrain = builder.buildFastestTrain()

print(classicTrain)
print("\n")
print(goldTrain)
print("\n")
print(fastestTrain)
