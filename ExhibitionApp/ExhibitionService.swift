//
//  ExhibitionApp.swift
//  ExhibitionApp
//
//  Created by 류지예 on 2023/02/21.
//

import Foundation
import SwiftUI

class ExhibitionService: ObservableObject {
    @Published var exhibition: ExhibitionResponse?

    private var apiKey: String {
        get {
            guard let filePath = Bundle.main.path(forResource: "APIKeys", ofType: "plist") else {
                fatalError("Couldn't find file 'APIKeys.plist'.")
            }

            let plist = NSDictionary(contentsOfFile: filePath)

            guard let value = plist?.object(forKey: "SeoulInfo") as? String else {
                fatalError("Couldn't find key 'SeoulInfo' in 'APIKeys.plist'.")
            }
            return value
        }
    }

    // App Transport Security has blocked a cleartext HTTP connection toopenapi.seoul.go.krsince it is insecure. Use HTTPS instead or add this domain to Exception Domains in your Info.plist.
    // 애플은 iOS 9 부터 앱이 기본적으로 https 를 사용하도록 요구
    // http를 사용하면 Info.plist 파일에 예외 도메인을 추가해야함
    // Exception Domains 키에 주소 추가, NSExceptionAllowsInsecureHTTPLoads YES로 값을 할당
    func getInformation() {
        let url = URL(string: "http://openapi.seoul.go.kr:8088/\(apiKey)/json/culturalEventInfo/1/100")
        guard let url = url else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }

            guard let data = data, let httpResponse = response as? HTTPURLResponse else {
                print("Error: No data or response")
                return
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                print("Error: Unexpected status code \(httpResponse.statusCode)")
                return
            }

            guard let exhibitionResponse = try? JSONDecoder().decode(ExhibitionResponse.self, from: data) else {
                print("Error: Failed to decode ExhibitionResponse")
                return
            }

            DispatchQueue.main.async {
                self.exhibition = exhibitionResponse
            }
        }.resume()
    }
}
