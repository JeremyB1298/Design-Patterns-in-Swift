
// MARK: - Models

struct User: Equatable {
    
    // MARK: Public properties
    
    let fullName: String
    let age: Int
    let company: String
    
    // MARK: - Equatable
    
    static func == (lhs: User, rhs: User) -> Bool {
        [
            lhs.fullName == rhs.fullName,
            lhs.age == rhs.age,
            lhs.company == rhs.company
        ].allSatisfy({ $0 == true })
    }
    
}

protocol Badge {
    func getUserInformations() -> User
}

final class BadgeImpl: Badge {
    
    // MARK: Private property
    
    private let user: User
    
    // MARK: Initializer
    
    init(user: User) {
        self.user = user
    }
    
    // MARK: Public method
    
    func getUserInformations() -> User {
        user
    }
}

// MARK: - Service

final class EntranceDoorService {
    
    // MARK: Private property
    
    private let users: [User]
    
    // MARK: Initializer
    
    init(users: [User]) {
        self.users = users
    }
    
    // MARK: Public method
    
    func check(badge: Badge) {
        let user = badge.getUserInformations()
        
        if users.contains(user)
        {
            open()
            // Wait 5 seconds
            close()
            print("User passed")
        }
        else
        {
            close()
            alert()
            print("Alert intruder 🚨")
        }
    }
    
    // MARK: Private methods
    
    private func open() {}
    private func close() {}
    private func alert() {}
    
}

// MARK: - Results

let user: User = .init(fullName: "User Fullname", age: 34, company: "DigitalCompany")
let intruder: User = .init(fullName: "User Intruder", age: 39, company: "None")
let userBadge: Badge = BadgeImpl(user: user)
let intruderBadge: Badge = BadgeImpl(user: intruder)

let entranceDoorService = EntranceDoorService(users: [user])

entranceDoorService.check(badge: userBadge)
entranceDoorService.check(badge: intruderBadge)
