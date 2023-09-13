//
//  SeminarDetail.swift
//  TicketLion_Admin
//
//  Created by 최세근 on 2023/09/06.
//

import SwiftUI

struct SeminarDetail: View {
    //    @State var columnVisibility = NavigationSplitViewVisibility.doubleColumn
    @StateObject var seminarStore: SeminarDetailStore = SeminarDetailStore()

    
    var body: some View {
        NavigationSplitView {
            SeminarDetailSidebar()
        } detail: {
            SeminarDetailInfo(seminars: Seminar.seminarsDummy[0], seminarData: .constant(Seminar.seminarsDummy[0]), seminarLocation: SeminarLocation(latitude: 37.5665, longitude: 126.9780, address: "서울시청"))
        }
        .tabItem {
            Image(systemName: "person")
            Text("회원관리")
        }
        .onAppear {
//            seminarStore.fetchSeminar()
        }
    }
}

struct SeminarDetail_Previews: PreviewProvider {
    static var previews: some View {
        SeminarDetail()
    }
}
