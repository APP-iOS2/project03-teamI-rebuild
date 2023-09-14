//
//  SeminarDetailModel.swift
//  TicketLion_Admin
//
//  Created by 최세근 on 2023/09/06.
//

//import Foundation
//
//struct DetailSeminar: Identifiable {
//    let id: String = UUID().uuidString
//    let category: [String]              // 세미나 카테고리는 여러가지..? 그래서 배열? 정해야할듯
//    let name: String                    // 세미나 이름
//    let seminarImage: String?            // 세미나 대표 사진 말하고 수정 필요, 커맨드 z 연타
//    let host: String                    // 세미나 호스트 이름
//    let details: String                 // 세미나 상세 정보
//    let form: Bool                      // 세미나 진행 형태 (오프라인,온라인)
//    var location: String?               // 장소 주소
//    let registerDate: String            // 모집시작날짜 ~ 모집마감날짜 구조체
//    let seminarDate: String             // 세미나시작날짜 ~ 세미나끝날짜 구조체
//    let maximumUserNumber: Int          // 세미나 모집 최대 인원
//    let closingStatus: Bool             // 세미나 마감 여부
//    var registerStartDate: Double       // 세미나 진행 시작 날짜
//    var registerStartTime: Double       // 세미나 진행 시작 시간
//    var registerEndDate: Double         // 세미나 진행 종료 날짜
//    var registerEndTime: Double         // 세미나 진행 종료 시간
//    var registerRunTime: Double         // 세미나 진행시간
//    var enterUsers: [String]            // 세미나 참가 유저 -> 저장값은 유저의 전화번호로!
////    let registerIsSelected: Bool        // 세미나 참가여부
////    let registerIsTaped: Bool           // 세미나 게시글 한번이라도 확인했을때 알려주는 Bool값
//
//    static let seminarsDummy: [DetailSeminar] = [
//        DetailSeminar(category: ["iOS Dev", "Front-End"], name: "피카추가 알려주는 강해지는 iOS앱!", seminarImage: "https://cdn.discordapp.com/attachments/1148284371355312269/1148792629149052968/pikachu.png", host: "피캇추", details: "일타강사 피캇추가 따라하기만 하면 강해지는 iOS앱 강의! 스위프트로 혼내줍니다.", form: false, location: "서울 종로구 종로3길", registerDate: "2083.09.06 ~ 2083.09.10", seminarDate: "2084.10.25 ~ 2084.10.27", maximumUserNumber: 80, closingStatus: false, registerStartDate: 5151321, registerStartTime: 5151321, registerEndDate: 5151321, registerEndTime: 5151321, registerRunTime: 5151321, enterUsers: ["2의재승","지우","웅이"]),
//        DetailSeminar(category: ["Android Dev", "Front-End"], name: "들으면 극락가는 Android앱!", seminarImage: "https://cdn.discordapp.com/attachments/1148284371355312269/1148812245766242344/lion.png", host: "우서코", details: "다같이 천국 갑시다!", form: false, location: "대전 서구 청사로", registerDate: "2083.10.06 ~ 2083.10.10", seminarDate: "2084.10.25 ~ 2084.10.26", maximumUserNumber: 40, closingStatus: false, registerStartDate: 5151321, registerStartTime: 5151321, registerEndDate: 5151321, registerEndTime: 5151321, registerRunTime: 5151321, enterUsers: ["2의재승","팀쿡"]),
//        DetailSeminar(category: ["Android Dev", "Back-End"], name: "자꾸만 듣고 싶은 Android앱!", seminarImage: "https://cdn.discordapp.com/attachments/1148284371355312269/1148816266266689596/329511e711e53bd0.png", host: "개굴", details: "마약같은 Android강의!", form: false, location: "대구 북구 엑스포로", registerDate: "2083.11.06 ~ 2083.11.10", seminarDate: "2084.11.20 ~ 2084.11.21", maximumUserNumber: 100, closingStatus: false, registerStartDate: 5151321, registerStartTime: 5151321, registerEndDate: 5151321, registerEndTime: 5151321, registerRunTime: 5151321, enterUsers: ["2의재승", "우서코", "피의종찬"]),
//        DetailSeminar(category: ["iOS Dev", "Back-End"], name: "화성으로 떠나는 iOS앱!", seminarImage: "https://cdn.discordapp.com/attachments/1148284371355312269/1148816384961282090/lion2.png", host: "일론 머스크", details: "일론 머스크를 따라하기만 하면 화성에 갈 수 있는 iOS앱 강의!", form: false, location: "부산 해운대구 BEX로", registerDate: "2083.12.06 ~ 2083.12.10", seminarDate: "2084.12.23 ~ 2084.12.24", maximumUserNumber: 150, closingStatus: false, registerStartDate: 5151321, registerStartTime: 5151321, registerEndDate: 5151321, registerEndTime: 5151321, registerRunTime: 5151321, enterUsers: ["2의재승","몸뚱아리","좌무커", "우서코", "피의종찬"])
//    ]
//}
