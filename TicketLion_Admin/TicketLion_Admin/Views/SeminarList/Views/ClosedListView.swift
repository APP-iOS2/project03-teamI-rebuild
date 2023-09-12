//
//  ClosedListView.swift
//  TicketLion_Admin
//
//  Created by 아라 on 2023/09/06.
//

import SwiftUI

enum ColosedOrder: String, CaseIterable {
    case register = "최근등록순"
    case closed = "최근마감순"
}

struct ClosedListView: View {
    @ObservedObject var seminarStore: SeminarListStore
    @State private var selectedSeminar: Seminar.ID? = nil
    @State private var order: ColosedOrder = .register
    @State private var isShowingSeminarInfo = false
    
    let currentDate = Date().timeIntervalSince1970
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Spacer()
                    Picker("sort closed list", selection: $order) {
                        ForEach(ColosedOrder.allCases, id:\.self) { order in
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
                    .width(180)
                    TableColumn("장소") { seminar in
                        Text(seminar.location ?? "온라인")
                    }
                    TableColumn("모집인원") { seminar in
                        Text(("\(seminar.enterUsers.count)/\(seminar.maximumUserNumber)"))
                    }
                    .width(120)
                    
                    TableColumn("마감날짜") { seminar in
                        Text(seminarStore.calculateDate(date: seminar.registerEndDate))
                    }
                    .width(100)
                } rows: {
                    switch order {
                    case .register:
                        ForEach(seminarStore.closedList) { seminar in
                            TableRow(seminar)
                        }
                    case .closed:
                        ForEach(seminarStore.closedList.sorted { $0.registerEndDate > $1.registerEndDate }) { seminar in
                            TableRow(seminar)
                        }
                    }
                }
            }
            .navigationDestination(isPresented: $isShowingSeminarInfo) {
                if let seminarId = selectedSeminar {
                    if let seminar = seminarStore.selectSeminar(id: seminarId) { SeminarInfoView(seminar: seminar)
                    }
                }
            }
        }
        .foregroundColor(.black)
        .onAppear {
            seminarStore.fetch()
        }
        .onChange(of: selectedSeminar) { seminarId in
            if let seminarId = seminarId {
                isShowingSeminarInfo.toggle()
            }
        }
    }
}

struct ClosedListView_Previews: PreviewProvider {
    static var previews: some View {
        ClosedListView(seminarStore: SeminarListStore())
    }
}
