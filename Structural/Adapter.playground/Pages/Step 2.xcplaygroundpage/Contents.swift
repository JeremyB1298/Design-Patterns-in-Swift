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

final class GoogleBadge {
    
    // MARK: Private properties
    
    let firstName: String
    let lastName: String
    let age: Int
    let company: String = "Google"
    
    // MARK: Initializer
    
    init(firstName: String, lastName: String, age: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
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
    
    // MARK: Public methods
    
    func check(badge: Any) {
        if let badge = badge as? Badge
        {
            check(badge: badge)
        }
        else if let googleBadge = badge as? GoogleBadge
        {
            check(googleBadge: googleBadge)
        }
        else
        {
            unauthorized()
        }
    }
    
    private func check(googleBadge: GoogleBadge) {
        let fullName = googleBadge.firstName + " " + googleBadge.lastName
        let age = googleBadge.age
        let company = googleBadge.company
        let user: User = .init(fullName: fullName, age: age, company: company)
        
        check(user: user)
    }
    
    private func check(badge: Badge) {
        let user = badge.getUserInformations()
        check(user: user)
    }
    
    private func check(user: User) {
        
        if users.contains(user)
        {
            open()
            // Wait 5 seconds
            close()
            print("User passed => \(user.fullName) from \(user.company)")
        }
        else
        {
            unauthorized()
        }
    }
    
    private func unauthorized() {
        close()
        alert()
        print("Alert intruder 🚨")
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
let googleBadge: GoogleBadge = .init(firstName: "Bob", lastName: "User", age: 29)
let googleUserFullName = googleBadge.firstName + " " + googleBadge.lastName
let googleUserAge = googleBadge.age
let googleUserCompany = googleBadge.company
let googleUser: User = .init(fullName: googleUserFullName, age: googleUserAge, company: googleUserCompany)
let intruderBadge: Badge = BadgeImpl(user: intruder)

let entranceDoorService = EntranceDoorService(
    users: [
        user,
        googleUser
    ]
)

entranceDoorService.check(badge: userBadge)
entranceDoorService.check(badge: intruderBadge)
entranceDoorService.check(badge: googleBadge)
