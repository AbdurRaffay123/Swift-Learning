import Foundation

class Order: ObservableObject {
    static let cakeTypes = ["Chocolate", "Vanilla", "Strawberry", "Blueberry"]

    @Published var type = 0
    @Published var quantity = 3

    @Published var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }

    @Published var extraFrosting = false
    @Published var addSprinkles = false
    
    @Published var name = ""
    @Published var address = ""
    @Published var city = ""
    @Published var zip = ""
    
    var hasValidAddress: Bool{
        if name.isEmpty || address.isEmpty || city.isEmpty || zip.isEmpty{
            return false
        }
        return true
    }
    
    var cost: Double{
        var Totalcost = Double(quantity)*2
        Totalcost += Double(type)/2
        
        if extraFrosting{
                Totalcost += Double(quantity)
        }
        
        if addSprinkles{
            Totalcost += Double(quantity)/2
        }
        
        return Totalcost
    }
    
}
