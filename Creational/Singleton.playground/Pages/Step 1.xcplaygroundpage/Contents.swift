
// MARK: - Models

struct DonutDough {
    
    // MARK: Private properties
    
    private let flour: Double = 125.0
    private let eggs: Double = 0.5
    private let yeast: Double = 0.5
    private let butter: Double = 18.8
    private let milk: Double = 0.075
    private let salt: Double = 0.5
    
    // MARK: Public method
    
    func calculateIngredients(for people: Int) -> (flour: Double, eggs: Double, yeast: Double, butter: Double, milk: Double, salt: Double) {
        return (
            flour: flour * Double(people),
            eggs: eggs * Double(people),
            yeast: yeast * Double(people),
            butter: butter * Double(people),
            milk: milk * Double(people),
            salt: salt * Double(people)
        )
    }
}

protocol DonutShop {
    func prepareDonuts()
}

struct GenevaDonutShop: DonutShop {
    
    // MARK: Private properties
    
    private let people: Int = 600
    private let donutDough: DonutDough
    
    // MARK: Initializer
    
    init(donutDough: DonutDough) {
        self.donutDough = donutDough
    }
    
    // MARK: Public method
    
    func prepareDonuts() {
        let ingredients = donutDough.calculateIngredients(for: people)
        print("Geneva Shop is preparing for \(people) people with \(ingredients.flour)g of flour, \(ingredients.eggs) eggs, \(ingredients.yeast) bags of yeast, \(ingredients.butter)g of butter, \(ingredients.milk)L of milk, and \(ingredients.salt)g of salt.")
    }
    
}

struct ParisDonutShop: DonutShop {
    
    // MARK: Private properties
    
    private let people: Int = 1000
    private let donutDough: DonutDough
    
    // MARK: Initializer
    
    init(donutDough: DonutDough) {
        self.donutDough = donutDough
    }
    
    // MARK: Public method
    
    func prepareDonuts() {
        let ingredients = donutDough.calculateIngredients(for: people)
        print("Paris Shop is preparing for \(people) people with \(ingredients.flour)g of flour, \(ingredients.eggs) eggs, \(ingredients.yeast) bags of yeast, \(ingredients.butter)g of butter, \(ingredients.milk)L of milk, and \(ingredients.salt)g of salt.")
    }
    
}

struct NewYorkDonutShop: DonutShop {
    
    // MARK: Private properties
    
    private let people: Int = 2500
    private let donutDough: DonutDough
    
    // MARK: Initializer
    
    init(donutDough: DonutDough) {
        self.donutDough = donutDough
    }
    
    // MARK: Public method
    
    func prepareDonuts() {
        let ingredients = donutDough.calculateIngredients(for: people)
        print("New York Shop is preparing for \(people) people with \(ingredients.flour)g of flour, \(ingredients.eggs) eggs, \(ingredients.yeast) bags of yeast, \(ingredients.butter)g of butter, \(ingredients.milk)L of milk, and \(ingredients.salt)g of salt.")
    }
    
}

// MARK: - Result

let donutDough = DonutDough()

let genevaDonutShop = GenevaDonutShop(donutDough: donutDough)
let parisDonutShop = ParisDonutShop(donutDough: donutDough)
let newYorkDonutShop = NewYorkDonutShop(donutDough: donutDough)

genevaDonutShop.prepareDonuts()
parisDonutShop.prepareDonuts()
newYorkDonutShop.prepareDonuts()
