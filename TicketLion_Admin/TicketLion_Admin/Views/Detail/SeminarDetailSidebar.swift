//
//  SeminarDetailSidebar.swift
//  TicketLion_Admin
//
//  Created by 최세근 on 2023/09/06.
//

import SwiftUI

struct SeminarDetailSidebar: View {
    
    @State var isLoading: Bool = false
    
    var body: some View {
        List(DetailSidebar.allCases) { detailSidebar in
            
//            if !isLoading {
//                ProgressView("로딩중...")
//            } else {
                Section {
                    ForEach(detailSidebar.subtitles, id: \.self) { subtitle in
                        NavigationLink {
                            switch detailSidebar {
                            case .detail:
                                SeminarDetailInfo(seminars: Seminar.seminarsDummy[0], seminarData: .constant(Seminar.seminarsDummy[0]), seminarLocation: SeminarLocation(latitude: 37.5665, longitude: 126.9780, address: "서울시청"))
                            case .attend:
                                ParticipationListVIew()
                                
                            }
                        } label: {
                            switch detailSidebar {
                            case .detail:
                                SeminarSidebarCell(title: subtitle, count: 2)
                            case .attend:
                                SeminarSidebarCell(title: subtitle, count: 4)
                            }
                        }
                    }
                }
                
//            }
        }
        .navigationTitle("해당된 세미나")

    }
}

struct SeminarDetailSidebar_Previews: PreviewProvider {
    static var previews: some View {
        SeminarDetailSidebar()
    }
}
