//
//  UserModel.swift
//  TicketLion_Admin
//
//  Created by 김종찬 on 2023/09/05.
//

import Foundation

struct User: Identifiable {
    
    /// UUID
    var id: String = UUID().uuidString
    /// 유저 이름
    let name: String
    /// 유저 전화번호
    let phoneNumber: String
    /// 유저 email
    let email: String
    /// 유저 password
    let password: String
    /// 유저 생년월일
    let birth: String
    /// 신청한 세미나
    var appliedSeminars: [String]
    /// 즐겨찾기한 세미나
    var favoriteSeminars: [String]
    /// 최근 본 세미나
    var recentlySeminars: [String]
    /// 취소한 세미나
    var canceledSeminars: [String]

static let usersDummy: [User] = [
    User(name: "생동재희", phoneNumber: "123123", email: "sadasdas", password: "1234", birth: "어제", appliedSeminars: ["1","2","3"], favoriteSeminars: ["1","2","3"], recentlySeminars: ["1","2","3"], canceledSeminars: ["1","2","3"]),
    User(name: "몸뚱아리", phoneNumber: "534534", email: "qweqweee", password: "1357", birth: "오늘", appliedSeminars: ["1","2","3"], favoriteSeminars: ["1","2","3"], recentlySeminars: ["1","2","3"], canceledSeminars: ["1","2","3"]),
    User(name: "우서코", phoneNumber: "635635", email: "ljkahsdj", password: "2468", birth: "내일", appliedSeminars: ["1","2","3"], favoriteSeminars: ["1","2","3"], recentlySeminars: ["1","2","3"], canceledSeminars: ["1","2","3"]),
    User(name: "좌강묵", phoneNumber: "345213", email: "adjfhadk", password: "6789", birth: "모레", appliedSeminars: ["1","2","3"], favoriteSeminars: ["1","2","3"], recentlySeminars: ["1","2","3"], canceledSeminars: ["1","2","3"]),
    User(name: "이의재승", phoneNumber: "345213", email: "adjfhadk", password: "6789", birth: "모레", appliedSeminars: ["1","2","3"], favoriteSeminars: ["1","2","3"], recentlySeminars: ["1","2","3"], canceledSeminars: ["1","2","3"]),
]
}
