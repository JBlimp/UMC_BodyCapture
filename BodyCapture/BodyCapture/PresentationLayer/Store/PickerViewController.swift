import UIKit

class PickerViewController: UIViewController {
    
    let cities = ["서울", "경기", "인천", "부산", "대구", "대전", "울산", "광주", "강원", "충북", "충남", "경북", "경남", "전북", "전남"]
    //let districts = [String]
    
    var cityPicker = UIPickerView()
    var districtPicker = UIPickerView()
    
    var cityInfo: [CityInfo] = [] // 도시 정보 배열
    var selectedDistricts: [DistrictInfo] = [] // 선택된 도시의 시/구 정보
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        if let sheetPresentationController = sheetPresentationController {
            sheetPresentationController.detents = [.medium()]
            setupPickerView()
        }
    }
    
    func setupPickerView() {
        cityPicker.delegate = self
        cityPicker.dataSource = self
        districtPicker.delegate = self
        districtPicker.dataSource = self
        
        // 여기에서 cityInfo 배열을 서버 또는 로컬 데이터소스에서 로드합니다.
        loadCityInfo()
        
        // 초기 선택된 도시의 시/구 정보 설정
        if let firstCityDistricts = cityInfo.first?.districts {
            selectedDistricts = firstCityDistricts
        }
        
        
        let stackView = UIStackView(arrangedSubviews: [cityPicker, districtPicker])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10

        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalToConstant: 200)

        ])
    }
    
    // 도시 정보를 로딩하는 함수 예시
    func loadCityInfo() {
        // cityInfo 배열을 실제 데이터로 채우는 로직을 구현합니다.
        // 예시 데이터:
         cityInfo = [CityInfo(cityName: "서울", districts: [DistrictInfo(districtName: "강남구", stores: []), DistrictInfo(districtName: "서초구", stores: [])]), CityInfo(cityName: "부산", districts: [DistrictInfo(districtName: "해운대구", stores: []), DistrictInfo(districtName: "수영구", stores: [])])]
    }
    
}
//MARK: - delegate2개
extension PickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    // UIPickerView DataSource Method
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == cityPicker {
            return cityInfo.count
        } else {
            return selectedDistricts.count
        }
    }
    
    // UIPickerView Delegate Method
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == cityPicker {
            return cityInfo[row].cityName
        } else {
            return selectedDistricts[row].districtName
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == cityPicker {
            selectedDistricts = cityInfo[row].districts
            districtPicker.reloadAllComponents()
        }
    }
}
