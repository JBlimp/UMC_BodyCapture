import UIKit

struct CompanyInfo: Decodable {
    let name: String
    let imageURL: URL? 
    let storeURL: URL?
    let price: String
    let rating: Double
    let district: String
    // 전화 번호, 상세 주소 처리?
    private enum CodingKeys: String, CodingKey {
        case name, imageURL = "photoPath", storeURL, price, rating, district
    }
}

// 도시별 스토어 정보를 담을 구조체
struct CityInfo: Decodable {
    let cityName: String
    let districts: [DistrictInfo]
}

// 구 또는 시 단위의 스토어 정보를 담을 구조체
struct DistrictInfo: Decodable {
    let districtName: String
    let stores: [CompanyInfo]
}
