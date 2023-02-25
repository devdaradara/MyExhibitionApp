//
//  Exhibition.swift
//  ExhibitionApp
//
//  Created by 류지예 on 2023/02/21.
//

import Foundation

// MARK: - ExhibitionResponse
struct ExhibitionResponse: Codable {
    let culturalEventInfo: CulturalEventInfo
    
    enum CodingKeys: String, CodingKey {
        case culturalEventInfo = "culturalEventInfo"
    }
}

// MARK: - CulturalEventInfo
struct CulturalEventInfo: Codable {
    let listTotalCount: Int
    let codeResult: CodeResult
    var row: [Row]

    enum CodingKeys: String, CodingKey {
        case listTotalCount = "list_total_count"
        case codeResult = "RESULT"
        case row = "row"
    }
}

// MARK: - CodeResult
struct CodeResult: Codable {
    let code, message: String

    enum CodingKeys: String, CodingKey {
        case code = "CODE"
        case message = "MESSAGE"
    }
}

// MARK: - Row
struct Row: Codable {
    let codename, guname, title, date: String
    let place: String
    let orgName: String
    let useTrgt, useFee, player: String
    let program: String
    let etcDesc: String
    let orgLink: String
    let mainImg: String
    let rgstdate: String
    let ticket: String
    let strtdate, endDate: String
    let themecode: String
    
    var isFavorite: Bool = false

    enum CodingKeys: String, CodingKey {
        case codename = "CODENAME"
        case guname = "GUNAME"
        case title = "TITLE"
        case date = "DATE"
        case place = "PLACE"
        case orgName = "ORG_NAME"
        case useTrgt = "USE_TRGT"
        case useFee = "USE_FEE"
        case player = "PLAYER"
        case program = "PROGRAM"
        case etcDesc = "ETC_DESC"
        case orgLink = "ORG_LINK"
        case mainImg = "MAIN_IMG"
        case rgstdate = "RGSTDATE"
        case ticket = "TICKET"
        case strtdate = "STRTDATE"
        case endDate = "END_DATE"
        case themecode = "THEMECODE"
    }
}

class FavoriteManager {
    static let shared = FavoriteManager()
    let userDefaults = UserDefaults.standard
    
    func saveFavorite(row: Row) {
        do {
            let data = try JSONEncoder().encode(row)
            userDefaults.set(data, forKey: row.title)
        } catch {
            print("Error saving favorite: \(error.localizedDescription)")
        }
    }
    
    func removeFavorite(row: Row) {
        userDefaults.removeObject(forKey: row.title)
    }
    
    func isFavorite(row: Row) -> Bool {
        return userDefaults.object(forKey: row.title) != nil
    }
    
    func loadFavorites() -> [Row] {
        let favorites = userDefaults.dictionaryRepresentation().compactMap { entry -> Row? in
            guard let data = entry.value as? Data else { return nil }
            do {
                let row = try JSONDecoder().decode(Row.self, from: data)
                return row
            } catch {
                print("Error loading favorite: \(error.localizedDescription)")
                return nil
            }
        }
        
        return favorites
    }
}
