import UIKit

struct CompanyInfo: Decodable {
    let name: String
    let imageURL: URL? 
    let storeURL: URL?
    let price: String
    let rating: Double
    
    private enum CodingKeys: String, CodingKey {
        case name, imageURL = "photoPath", storeURL, price, rating
    }
}
