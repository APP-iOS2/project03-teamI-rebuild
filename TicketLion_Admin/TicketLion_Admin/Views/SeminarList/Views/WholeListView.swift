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
    @StateObject var seminarStore: SeminarListStore
    @State private var selectedSeminar: Seminar.ID? = nil
    @State private var order: Order = .recent
    @State private var isShowingSeminarInfo = false
    @State private var currentPage: Int = 1
    let itemsPerPage = 17
    
    var totalPages: Int {
        Int(ceil(Double(seminarStore.seminarList.count) / Double(itemsPerPage)))
    }
    
    var seminarList: [Seminar] {
        switch order {
        case .recent:
            return seminarStore.seminarList
        case .deadline:
            let sort = seminarStore.recruitingList.sorted { $0.registerEndDate < $1.registerEndDate } + seminarStore.closedList.sorted { $0.registerEndDate > $1.registerEndDate }
            return sort
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
                TopView(order: $order, type: .whole)
                
                WholeTableView(seminarStore: seminarStore, selectedSeminar: $selectedSeminar, currentPageList: currentPageList)
                
                PageListView(currentPage: $currentPage, totalPages: totalPages)
            }
            .padding(.vertical, 15)
            .navigationDestination(isPresented: $isShowingSeminarInfo) {
                if let seminarId = selectedSeminar {
                    if let seminar = seminarStore.selectSeminar(id: seminarId) { SeminarInfoView(seminar: seminar)
                    }
                }
            }
        }
        .onAppear {
            UIScrollView.appearance().bounces = false
            seminarStore.fetch()
            selectedSeminar = nil
        }
        .onChange(of: selectedSeminar) { seminarId in
            if let _ = seminarId {
                isShowingSeminarInfo.toggle()
            }
        }
    }
}


struct WholeTableView: View {
    @StateObject var seminarStore: SeminarListStore
    @Binding var selectedSeminar: Seminar.ID?
    var currentPageList: [Seminar]
    
    var body: some View {
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
            ForEach(currentPageList) { seminar in
                TableRow(seminar)
            }
        }
    }
}

struct WholeListView_Previews: PreviewProvider {
    static var previews: some View {
        WholeListView(seminarStore: SeminarListStore())
    }
}
