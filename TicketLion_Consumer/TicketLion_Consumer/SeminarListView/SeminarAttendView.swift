//
//  SeminarAttendView.swift
//  TicketLion_Comsumer
//
//  Created by 윤진영 on 2023/09/06.
//

import SwiftUI

struct SeminarAttendView: View {
    var seminar: Seminar
    let user: User
    @Binding var isShowingDetail: Bool

    func timeCreator(_ time: Double) -> String {
        let createdAt: Date = Date(timeIntervalSince1970: time)
        let fomatter: DateFormatter = DateFormatter()
        fomatter.dateFormat = "hh:mm a"
        
        return fomatter.string(from: createdAt)
    }
    
    func dateCreator(_ time: Double) -> String {
        let createdAt: Date = Date(timeIntervalSince1970: time)
        let fomatter: DateFormatter = DateFormatter()
        fomatter.dateFormat = "yyyy년 MM월 dd일"
        
        return fomatter.string(from: createdAt)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Divider()
                        .padding(7)
                    
                    VStack(alignment: .leading) {
                        Section("신청한 세미나") {
                            Group{
                                Text("[ \(seminar.name) ]")
                                    .font(.body.bold())
                                Text("진행날짜: \(dateCreator(_:seminar.registerStartDate)) ~ \(dateCreator(_:seminar.registerEndDate))")
                                Text("진행시간: \(timeCreator(_:seminar.registerStartDate)) ~ \(timeCreator(_:seminar.registerEndDate))")
                                Text("강연자: \(seminar.host)")
                                Text("장소: \(seminar.location ?? "")")
                            }.font(.body)
                                .padding(.leading,20)
                        }.font(.title2.bold())
                            .padding(.leading,10)
                            .padding(5)
                    }
                    Divider()
                    
                    VStack(alignment: .leading) {
                        Section("신청자 정보") {
                            Group{
                                Text("이름: \(user.name)")
                                Text("이메일: \(user.email)")
                                Text("전화번호: \(user.phoneNumber)")
                            }.font(.body)
                                .padding(.leading,20)
                        }.font(.title2.bold())
                            .padding(.leading,10)
                            .padding(5)
                    }
                    Divider()
                    SeminarAttendPlusView(isShowingDetail: $isShowingDetail)
                }.navigationTitle("신청하기")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct SeminarAttendView_Previews: PreviewProvider {
    static var previews: some View {
        SeminarAttendView(seminar: Seminar.seminarsDummy[0],
                          user: User.usersDummy[0], isShowingDetail: .constant(true))

    }
}
