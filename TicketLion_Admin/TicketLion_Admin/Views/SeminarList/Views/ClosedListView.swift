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
    @State private var currentPage: Int = 1
    let itemsPerPage = 17
    
    var totalPages: Int {
        Int(ceil(Double(seminarStore.closedList.count) / Double(itemsPerPage)))
    }
    
    var seminarList: [Seminar] {
        switch order {
        case .register:
            return seminarStore.closedList
        case .closed:
            return seminarStore.closedList.sorted { $0.registerEndDate > $1.registerEndDate }
        }
    }
    
    var currentPageList: [Seminar] {
        let startIndex = (currentPage - 1) * itemsPerPage
        let endIndex = min(startIndex + itemsPerPage, seminarList.count)
        return Array(seminarList[startIndex..<endIndex])
    }
    
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
                    .padding(.trailing, 15)
                }
                .padding(.top, 15)
                .padding(.bottom, 10)
                
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
                    ForEach(currentPageList) { seminar in
                        TableRow(seminar)
                    }
                }
                
                HStack {
                    ForEach(1..<totalPages + 1, id: \.self) { num in
                        Button {
                            currentPage = num
                        } label: {
                            Text("\(num)")
                                .fontWeight(currentPage == num ? .bold : .regular)
                                .foregroundColor(currentPage == num ? .black : .gray)
                                .font(.headline)
                        }
                        .padding(.horizontal, 5)
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
        .onAppear {
            seminarStore.fetch()
        }
        .onChange(of: selectedSeminar) { seminarId in
            if let _ = seminarId {
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
