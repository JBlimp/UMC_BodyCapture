import UIKit
import Alamofire
import Combine
//초기 디폴트 설정구현

class PickerViewController: UIViewController {
    
    let cityInfoManager = CityInfoManager()
    
    let cities = ["서울", "경기", "인천", "부산", "대구", "대전", "울산", "광주", "강원", "충북", "충남", "경북", "경남", "전북", "전남", "제주"]
    
    let cityTableView = UITableView()
    let districtTableView = UITableView()
    //정보 호출
    var cancellables = Set<AnyCancellable>()
    var cityInfo: [CityInfo] = [] // 도시 정보 배열
    var districtsByCity: [DistrictInfo] = [] // 선택된 도시의 시/구 정보
    //정보 전달storeController로
    var selectedDistricts: [String] = []
    var selectedCity: String?
    
    var selectionPublisher = PassthroughSubject<(selectedCity: String, selectedDistricts: [String]), Never>()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        if let sheetPresentationController = sheetPresentationController {
            sheetPresentationController.detents = [.medium()]
        }
        setupTableView()
        loadAllCityInfo()
    }
    
    func setupTableView() {
        districtTableView.allowsMultipleSelection = true
        
        cityTableView.delegate = self
        cityTableView.dataSource = self
        districtTableView.delegate = self
        districtTableView.dataSource = self
        
        cityTableView.register(CityTableCell.self, forCellReuseIdentifier: CityTableCell.identifier)
        districtTableView.register(DistrictTableCell.self, forCellReuseIdentifier: DistrictTableCell.identifier)
        
        let stackView = UIStackView(arrangedSubviews: [cityTableView, districtTableView])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    //MARK: - data:::: API명세!!!
    func loadAllCityInfo() {
//        let publishers = cities.map { cityName in
//                fetchCompanyInfosForCity(cityName: cityName)
//                    .map { companyInfos -> CityInfo in
//                        return self.cityInfoManager.organizeCompanyInfosByDistrict(companyInfos: companyInfos, for: cityName)
//                    }
//                    .catch { _ in Just(CityInfo.empty) } // 오류 처리
//            }
//            
//            Publishers.MergeMany(publishers)
//                .collect() // 모든 도시 정보를 수집
//                .sink(receiveCompletion: { _ in }, receiveValue: { cityInfos in
//                    self.cityInfo = cityInfos
//                    self.cityTableView.reloadData()
//                })
//                .store(in: &cancellables) // 메모리 관리를 위해 cancellables에 저장
        //하드코딩
        cityInfo = [
            CityInfo(cityName: "서울", districts: [
                DistrictInfo(districtName: "강남구", stores: [
                    CompanyInfo(name: "Store A", imageURL: nil, storeURL: nil,  district: "강남구"),
                    CompanyInfo(name: "Store B", imageURL: nil, storeURL: nil,  district: "강남구")
                ]),
                DistrictInfo(districtName: "서초구", stores: [
                    CompanyInfo(name: "Store C", imageURL: nil, storeURL: nil,  district: "서초구")
                ])
            ]),
            CityInfo(cityName: "부산", districts: [
                DistrictInfo(districtName: "해운대구", stores: [
                    CompanyInfo(name: "Store D", imageURL: nil, storeURL: nil,  district: "해운대구")
                ]),
                DistrictInfo(districtName: "수영구", stores: [
                    CompanyInfo(name: "Store E", imageURL: nil, storeURL: nil,  district: "수영구")
                ])
            ])
        ]
        cityTableView.reloadData()
    }
}


//func fetchCompanyInfosForCity(cityName: String, completion: @escaping ([CompanyInfo]) -> Void) {
//    // 서버의 API (예를 들어, 도시 이름을 쿼리 파라미터로 사용)
//    let url = "https://yourserver.com/api/companyInfos?city=\(cityName)"
//    
//    // Alamofire를 사용하여 요청
//    AF.request(url).responseDecodable(of: [CompanyInfo].self) { response in
//        switch response.result {
//        case .success(let companyInfos):
//            completion(companyInfos)
//        case .failure(let error):
//            print("Error fetching company infos for city \(cityName): \(error)")
//            completion([]) //
//        }
//    }
//}
//category(bp, ms) -> city -> district

func fetchCompanyInfosForCity(cityName: String) -> AnyPublisher<[CompanyInfo], AFError> {
    let url = "https://yourserver.com/api/companyInfos?city=\(cityName)"
    return AF.request(url)
        .publishDecodable(type: [CompanyInfo].self)
        .value() // `value`는 성공 응답만을 추출
        .receive(on: DispatchQueue.main) // 메인 스레드에서 받기
        .eraseToAnyPublisher() // 타입을 숨김 (AnyPublisher로 반환)
}


//MARK: - delegate 2종류!!
extension PickerViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == cityTableView {
            return cityInfo.count
        } else if tableView == districtTableView {
            return districtsByCity.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == cityTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CityTableCell", for: indexPath) as! CityTableCell
            cell.cityName.text = cityInfo[indexPath.row].cityName
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: DistrictTableCell.identifier, for: indexPath)
            let districtName = districtsByCity[indexPath.row].districtName
            cell.textLabel?.text = districtName
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == cityTableView {
            selectedCity = cityInfo[indexPath.row].cityName
            districtsByCity = cityInfo[indexPath.row].districts
            districtTableView.reloadData()
            selectedDistricts.removeAll()
            
        } else if tableView == districtTableView {
            let districtName = districtsByCity[indexPath.row].districtName
            selectedDistricts.append(districtName)
            
            if !selectedDistricts.contains(districtName) {
                selectedDistricts.append(districtName)
                print("지역 선택됨: \(districtName)") // 로그 추가
            }
            // 선택된 지역 정보 방출
            if let selectedCity = selectedCity {
                print("선택 정보 방출: 도시=\(selectedCity), 지역=\(selectedDistricts)") // 로그 추가
                selectionPublisher.send((selectedCity: selectedCity, selectedDistricts: selectedDistricts))
            }
        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
            if tableView == districtTableView {
                let districtName = districtsByCity[indexPath.row].districtName
                selectedDistricts.removeAll { $0 == districtName }
                print("지역 선택됨: \(districtName)")
                
                // 선택 해제된 지역 정보 업데이트
                if let selectedCity = selectedCity {
                    print("선택 정보 방출: 도시=\(selectedCity), 지역=\(selectedDistricts)")
                    selectionPublisher.send((selectedCity: selectedCity, selectedDistricts: selectedDistricts))
                }
            }
        }
    
}

