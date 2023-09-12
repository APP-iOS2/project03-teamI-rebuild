//
//  Model.swift
//  TicketLion_Admin
//
//  Created by 김종찬 on 2023/09/05.
//
import SwiftUI

struct Seminar: Identifiable {
    
    /// UUID
    var id: String = UUID().uuidString
    /// 세미나 카테고리
    var category: [String]
    /// 세미나 이름
    var name: String
    /// 세미나 대표 사진
    var seminarImage: String
    /// 세미나 호스트 이름
    var host: String
    /// 세미나 상세 정보
    var details: String
    /// 장소 주소
    var location: String?
    /// 세미나 모집 최대 인원
    var maximumUserNumber: Int
    /// 세미나 마감 여부
    var closingStatus: Bool
    /// 세미나 모집 시작 날짜
    var registerStartDate: Double
    /// 세미나 모집 종료 날짜
    var registerEndDate: Double
    /// 세미나 진행 시작 날짜
    var seminarStartDate: Double
    /// 세미나 진행 종료 날짜
    var seminarEndDate: Double
    /// 세미나 참가 유저
    var enterUsers: [String]            // 저장값은 유저의 전화번호로!
//    let form: Bool                      // 세미나 진행 형태 (오프라인,온라인)
//    let registerDate: String            // 모집시작날짜 ~ 모집마감날짜 구조체
//    let seminarDate: String             // 세미나시작날짜 ~ 세미나끝날짜 구조체
//    let registerIsSelected: Bool        // 세미나 참가여부
//    let registerIsTaped: Bool           // 세미나 게시글 한번이라도 확인했을때 알려주는 Bool값
    
    static let seminarsDummy: [Seminar] = [
        Seminar(category: ["iOS Dev", "Front-End"], name: "피카추가 알려주는 강해지는 iOS앱!", seminarImage: "https://cdn.discordapp.com/attachments/1148284371355312269/1148792629149052968/pikachu.png", host: "피캇추", details: "일타강사 피캇추가 따라하기만 하면 강해지는 iOS앱 강의! 스위프트로 혼내줍니다.", location: "서울 종로구 종로3길", maximumUserNumber: 80, closingStatus: false, registerStartDate: 5151321, registerEndDate: 5151321, seminarStartDate: 5151321, seminarEndDate: 5151321, enterUsers: ["2의재승","지우","웅이"]),
        Seminar(category: ["Android Dev", "Front-End"], name: "들으면 극락가는 Android앱!", seminarImage: "https://mblogthumb-phinf.pstatic.net/MjAxODA4MTVfMjI5/MDAxNTM0MzM1NjYwOTEw.DQHKsUBpla1Ugx-5wbDKiEqTymCOD8hXeZ21PJm0ohsg.5MylK5vYRe7DYijif1xnH6Xic6RDe9D8YTLy641e2o4g.PNG.qbxlvnf11/7b5e56_d42a0c16a2e64a72b0221462c555f818-mv2.png?type=w800", host: "우서코", details: "다같이 천국 갑시다!", location: "서울 종로구 종로3길", maximumUserNumber: 80, closingStatus: false, registerStartDate: 5151321, registerEndDate: 5151321, seminarStartDate: 5151321, seminarEndDate: 5151321, enterUsers: ["2의재승","팀쿡"]),
        Seminar(category: ["Android Dev", "Back-End"], name: "자꾸만 듣고 싶은 안드로이드 Back-End!", seminarImage: "https://images.velog.io/images/c-on/post/2b806749-2868-4c76-8c3f-9f1e3fdc3797/hire-backend-developer.jpg", host: "개굴", details: "마약같은 Android 서버강의!", location: "서울 종로구 종로3길", maximumUserNumber: 80, closingStatus: false, registerStartDate: 5151321, registerEndDate: 5151321, seminarStartDate: 5151321, seminarEndDate: 5151321, enterUsers: ["2의재승", "우서코", "피의종찬"]),
        Seminar(category: ["iOS Dev", "Back-End"], name: "화성으로 떠나는 iOS Back-End!", seminarImage: "https://assets-prd.ignimgs.com/2022/01/28/starcraft-2-wings-of-liberty-button-crop-1643355282078.jpg?width=300&crop=1%3A1%2Csmart&dpr=2", host: "일론 머스크", details: "일론 머스크를 따라하기만 하면 화성에 갈 수 있는 iOS 서버 강의!", location: "서울 종로구 종로3길", maximumUserNumber: 80, closingStatus: false, registerStartDate: 5151321, registerEndDate: 5151321, seminarStartDate: 5151321, seminarEndDate: 5151321, enterUsers: ["2의재승","몸뚱아리","좌무커", "우서코", "피의종찬"]),
    ]
}
