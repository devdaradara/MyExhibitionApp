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
    let row: [Row]

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
