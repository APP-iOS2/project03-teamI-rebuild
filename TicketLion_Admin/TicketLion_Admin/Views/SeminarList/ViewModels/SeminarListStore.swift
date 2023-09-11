//
//  SeminalListStore.swift
//  TicketLion_Admin
//
//  Created by 아라 on 2023/09/06.
//

import Foundation

class SeminarListStore: ObservableObject {
    @Published var seminarList: [Seminar] = [
        Seminar(category: ["iOS Dev", "Front-End"], name: "피카추가 알려주는 강해지는 iOS앱!", seminarImage: "https://cdn.discordapp.com/attachments/1148284371355312269/1148792629149052968/pikachu.png", host: "피캇추", details: "일타강사 피캇추가 따라하기만 하면 강해지는 iOS앱 강의! 스위프트로 혼내줍니다.", location: "서울 종로구 종로3길", maximumUserNumber: 80, closingStatus: false, registerStartDate: 5151321, registerEndDate: 1614411513.632564, seminarStartDate: 5151321, seminarEndDate: 5151321, enterUsers: ["2의재승","지우","웅이"]),
        Seminar(category: ["Android Dev", "Front-End"], name: "들으면 극락가는 Android앱!", seminarImage: "https://mblogthumb-phinf.pstatic.net/MjAxODA4MTVfMjI5/MDAxNTM0MzM1NjYwOTEw.DQHKsUBpla1Ugx-5wbDKiEqTymCOD8hXeZ21PJm0ohsg.5MylK5vYRe7DYijif1xnH6Xic6RDe9D8YTLy641e2o4g.PNG.qbxlvnf11/7b5e56_d42a0c16a2e64a72b0221462c555f818-mv2.png?type=w800", host: "우서코", details: "다같이 천국 갑시다!", location: "서울 종로구 종로3길", maximumUserNumber: 80, closingStatus: false, registerStartDate: 5151321, registerEndDate: 1694011513.632564, seminarStartDate: 5151321, seminarEndDate: 5151321, enterUsers: ["2의재승","팀쿡"]),
        Seminar(category: ["Android Dev", "Back-End"], name: "자꾸만 듣고 싶은 안드로이드 Back-End!", seminarImage: "https://images.velog.io/images/c-on/post/2b806749-2868-4c76-8c3f-9f1e3fdc3797/hire-backend-developer.jpg", host: "개굴", details: "마약같은 Android 서버강의!", location: "서울 종로구 종로3길", maximumUserNumber: 80, closingStatus: false, registerStartDate: 5151321, registerEndDate: 5355553, seminarStartDate: 5151321, seminarEndDate: 5151323, enterUsers: ["2의재승", "우서코", "피의종찬"]),
        Seminar(category: ["iOS Dev", "Back-End"], name: "화성으로 떠나는 iOS Back-End!", seminarImage: "https://assets-prd.ignimgs.com/2022/01/28/starcraft-2-wings-of-liberty-button-crop-1643355282078.jpg?width=300&crop=1%3A1%2Csmart&dpr=2", host: "일론 머스크", details: "일론 머스크를 따라하기만 하면 화성에 갈 수 있는 iOS 서버 강의!", location: "서울 종로구 종로3길", maximumUserNumber: 80, closingStatus: false, registerStartDate: 5151322, registerEndDate: 1794411513.632564, seminarStartDate: 5151321, seminarEndDate: 5151321, enterUsers: ["2의재승","몸뚱아리","좌무커", "우서코", "피의종찬"]),
    ]
    let currentDate = Date().timeIntervalSince1970
    var recruitingList: [Seminar] {
        seminarList.filter { $0.registerEndDate >= currentDate }
    }
    var closedList: [Seminar] {
        seminarList.filter { $0.registerEndDate < currentDate }
    }
    
    func calculateDate(date: Double) -> String {
        let date = Date(timeIntervalSince1970: date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy.MM.dd"
        return dateFormatter.string(from: date)
    }
}
