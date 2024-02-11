
import UIKit
import Alamofire

protocol CompanyInfoRepository {
    func fetchCompanyInfos(categoryIndex: Int, completion: @escaping ([CompanyInfo]) -> Void)
}

class AlamofireCompanyInfoRepository: CompanyInfoRepository {
    let titles = ["Studio", "Makeup", "Hairshop", "Package"]
    
    let ex :[CompanyInfo] = [
        CompanyInfo(name: "Company A", imageURL: nil, storeURL: URL(string: "https://www.naver.com"), price: "$100", rating: 4.5),
        CompanyInfo(name: "Company B", imageURL: nil, storeURL: URL(string: "https://www.naver.com"), price: "$200", rating: 4.2),
        CompanyInfo(name: "Company C", imageURL: nil, storeURL: URL(string: "https://www.naver.com"), price: "$150", rating: 4.8),
        CompanyInfo(name: "Company D", imageURL: nil, storeURL: URL(string: "https://www.naver.com"), price: "$120", rating: 4.0),
        CompanyInfo(name: "Company E", imageURL: nil, storeURL: URL(string: "https://www.naver.com"), price: "$120", rating: 4.0)
    ]
    
    func fetchCompanyInfos(categoryIndex: Int, completion: @escaping ([CompanyInfo]) -> Void) {
        let category = titles[categoryIndex]
        let url = "https://yourserver.com/api/\(category)"
        
        AF.request(url).responseDecodable(of: [CompanyInfo].self) { response in
            switch response.result {
            case .success(let companyInfos):
                completion(companyInfos)
            case .failure(let error):
                print(error)
                completion(self.ex)
            }
        }
        
    }

}
