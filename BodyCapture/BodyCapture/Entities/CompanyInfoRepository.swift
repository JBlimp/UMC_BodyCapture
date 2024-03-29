
import UIKit
import Alamofire

protocol CompanyInfoRepository {
    func fetchCompanyInfos(categoryIndex: Int, completion: @escaping ([CompanyInfo]) -> Void)
}

//찜한 스토어 목록도 여기서 받아오게 코드 수정함
class AlamofireCompanyInfoRepository: CompanyInfoRepository {
    let titles = ["Studio", "Makeup", "Hairshop", "Package", "Heart"]
    
    let ex :[CompanyInfo] = [
        CompanyInfo(name: "Company A", imageURL: nil, storeURL: URL(string: "https://www.naver.com"), district: "강남구"),
        CompanyInfo(name: "Company B", imageURL: nil, storeURL: URL(string: "https://www.naver.com"), district: "서초구"),
        CompanyInfo(name: "Company C", imageURL: nil, storeURL: URL(string: "https://www.naver.com"), district: "송파구"),
        CompanyInfo(name: "Company D", imageURL: nil, storeURL: URL(string: "https://www.naver.com"), district: "용산구"),
        CompanyInfo(name: "Company E", imageURL: nil, storeURL: URL(string: "https://www.naver.com"), district: "해운대구")
    ]
//MARK: - API명세!!!!
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
