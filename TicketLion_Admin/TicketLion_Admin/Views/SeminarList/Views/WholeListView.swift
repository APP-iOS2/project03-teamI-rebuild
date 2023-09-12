//
//  WholeListView.swift
//  TicketLion_Admin
//
//  Created by 아라 on 2023/09/06.
//

import SwiftUI

enum Order: String, CaseIterable {
    case recent = "최근등록순"
    case deadline = "마감임박순"
}

struct WholeListView: View {
    @ObservedObject var seminarStore: SeminarListStore
    @State private var selectedSeminar: Seminar.ID? = nil
    @State private var order: Order = .recent
    let currentDate = Date().timeIntervalSince1970
    
    var body: some View {
        if let seminarId = selectedSeminar {
            SeminarDetail()
        } else {
            NavigationStack {
                HStack {
                    Spacer()
                    Picker("sort whole list", selection: $order) {
                        ForEach(Order.allCases, id:\.self) { order in
                            Text(order.rawValue)
                        }
                    }
                    .pickerStyle(.menu)
                    .padding([.bottom, .trailing], 15)
                }
                
                Table(of: Seminar.self, selection: $selectedSeminar) {
                    TableColumn("세미나명") { seminar in
                        Text(seminar.name)
                    }
                    
                    TableColumn("주최자") { seminar in
                        Text(seminar.host)
                    }
                    .width(120)
                    
                    TableColumn("장소") { seminar in
                        Text(seminar.location ?? "온라인")
                    }
                    
                    TableColumn("모집인원") { seminar in
                        Text(("\(seminar.enterUsers.count)/\(seminar.maximumUserNumber)"))
                    }
                    .width(80)
                    
                    TableColumn("마감날짜") { seminar in
                        Text(seminarStore.calculateDate(date: seminar.registerEndDate))
                    }
                    .width(100)
                    
                    TableColumn("마감여부") { seminar in
                        Text(seminarStore.recruitingList.contains(where: { $0.id == seminar.id }) ? "진행중" : "마감")
                    }
                    .width(70)
                } rows: {
                    switch order {
                    case .recent:
                        ForEach(seminarStore.seminarList) { seminar in
                            TableRow(seminar)
                        }
                    case .deadline :
                        // 진행중인 세미나는 마감 될 순서
                        // 모집 끝난 세미나는 최근에 마감 된 순서
                        let sort = seminarStore.recruitingList.sorted { $0.registerEndDate < $1.registerEndDate } + seminarStore.closedList.sorted { $0.registerEndDate > $1.registerEndDate }
                        
                        ForEach(sort) { seminar in
                            TableRow(seminar)
                        }
                    }
                }
                
                HStack {
                    NavigationLink {
						SeminarAddView(seminarStore: SeminarStore(), chipsViewModel: ChipsViewModel())
                    } label: {
                        Text("세미나 등록하기")
                            .font(.title).bold()
                    }
                    .padding([.horizontal, .vertical], 20)
                    .buttonStyle(.bordered)
                }
            }
            //.tint(Color(hex: 0xD7D7D9))
            .foregroundColor(.black)
        }
    }
}

struct WholeListView_Previews: PreviewProvider {
    static var previews: some View {
        WholeListView(seminarStore: SeminarListStore())
    }
}
