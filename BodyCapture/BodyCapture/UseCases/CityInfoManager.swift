//
//  CityInfoManager.swift
//  BodyCapture
//
//  Created by 하상준 on 2/15/24.
//

import Foundation

class CityInfoManager {
    
    func organizeCompanyInfosByDistrict(companyInfos: [CompanyInfo], for cityName: String) -> CityInfo {
        
        var districtDict = [String: [CompanyInfo]]()

        // 각 CompanyInfo를 district를 기준으로 조직
        for companyInfo in companyInfos {
            let districtName = companyInfo.district
            if districtDict[districtName] == nil {
                districtDict[districtName] = []
            }
            districtDict[districtName]?.append(companyInfo)
        }

        // DistrictInfo 객체 생성 
        let districts = districtDict.map { districtName, companies in
            DistrictInfo(districtName: districtName, stores: companies)
        }

        // CityInfo 객체 반환
        return CityInfo(cityName: cityName, districts: districts)
    }

    // 데이터베이스로부터 도시별 CompanyInfo 배열을 가져와 처리
    // 예시: 서울에 해당하는 CompanyInfo 배열을 가져와 처리
    // let seoulCompanyInfos: [CompanyInfo] = fetchCompanyInfos(forCity: "서울")
    // let seoulCityInfo = organizeCompanyInfosByDistrict(companyInfos: seoulCompanyInfos, for: "서울")

    
}
