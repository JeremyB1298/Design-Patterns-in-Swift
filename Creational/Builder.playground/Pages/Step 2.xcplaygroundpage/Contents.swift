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
        "Wagon n°\(id), \(name). Has the capacity of \(capacity) persons,"
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

// MARK: - Train creation

func createTrain() -> Train {
    
    // MARK: Initialize variables

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

    // MARK: Connection

    locomotive.backConnectionId = secondClassWagon.id

    secondClassWagon.frontConnectionId = locomotive.id
    secondClassWagon.backConnectionId = firstClassWagon.id

    firstClassWagon.frontConnectionId = secondClassWagon.id
    firstClassWagon.backConnectionId = restaurantWagon.id

    restaurantWagon.frontConnectionId = firstClassWagon.id

    // MARK: Train initialize

    var train = Train(
        name: "My train 🚃 step 2",
        wagons: [
            locomotive,
            secondClassWagon,
            firstClassWagon,
            restaurantWagon
        ]
    )
    
    // MARK: Return result
    
    return train
}

// MARK: Result

let firstTrain = createTrain()
let secondTrain = createTrain()
let thirdTrain = createTrain()

print(firstTrain)
print(secondTrain)
print(thirdTrain)
