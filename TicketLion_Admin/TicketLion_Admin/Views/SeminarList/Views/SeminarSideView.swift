//
//  SeminarSideView.swift
//  TicketLion_Admin
//
//  Created by 아라 on 2023/09/06.
//

import SwiftUI

enum SeminarListSidebar: String, CaseIterable {
    case all = "전체 세미나 목록"
    case recruiting = "모집중인 세미나"
    case done = "모집이 끝난 세미나"
}

struct SeminarSideView: View {
    @ObservedObject var seminarStore: SeminarListStore
    
    var body: some View {
        List(SeminarListSidebar.allCases, id: \.self) { list in
            switch list {
            case .all:
                NavigationLink {
                    WholeListView(seminarStore: seminarStore)
                } label: {
                    SeminarListCellView(title: list.rawValue, count: seminarStore.seminarList.count)
                }
            case .recruiting:
                NavigationLink {
                    RecruitingListView(seminarStore: seminarStore)
                } label: {
                    SeminarListCellView(title: list.rawValue, count: seminarStore.recruitingList.count)
                }
            case .done:
                NavigationLink {
                    ClosedListView(seminarStore: seminarStore)
                } label: {
                    SeminarListCellView(title: list.rawValue, count: seminarStore.closedList.count)
                }
            }
        }
        .navigationTitle("세미나 목록")
        .tint(Color(hex: 0xD7D7D9))
    }
}

struct SeminarListCellView: View {
    var title: String
    var count: Int
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.black)
            Spacer()
            Text("\(count)")
                .foregroundColor(.gray)
        }
        .font(.title2)
    }
}

struct SeminarSideView_Previews: PreviewProvider {
    static var previews: some View {
        SeminarSideView(seminarStore: SeminarListStore())
    }
}
