import UIKit

struct CompanyInfo: Decodable {
    let name: String
    let imageURL: URL?
    let price: String
    let rating: Double
    
    private enum CodingKeys: String, CodingKey {
        case name, imageURL = "photoPath", price, rating
    }
}
