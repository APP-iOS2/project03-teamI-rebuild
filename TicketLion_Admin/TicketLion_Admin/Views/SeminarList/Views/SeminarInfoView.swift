//
//  DetailTestView.swift
//  TicketLion_Admin
//
//  Created by 아라 on 2023/09/12.
//

import SwiftUI

enum SeminarInfo: String, CaseIterable {
    case detail = "상세정보"
    case participation = "참가목록"
}

struct SeminarInfoView: View {
    @State private var info: SeminarInfo = .detail
    let seminar: Seminar
    
    var body: some View {
        VStack {
            Picker("sort whole list", selection: $info) {
                ForEach(SeminarInfo.allCases, id:\.self) { info in
                    Text(info.rawValue)
                }
            }
            .pickerStyle(.segmented)
            .padding([.bottom, .trailing], 15)
            
            switch info {
            case .detail:
                SeminarDetailInfo(seminars: seminar, seminarData: .constant(Seminar.seminarsDummy[0]), seminarLocation: SeminarLocation(latitude: 37.5665, longitude: 126.9780, address: "서울시청"))
            case .participation:
                ParticipationListVIew()
            }
        }
    }
}

struct SeminarInfoView_Previews: PreviewProvider {
    static var previews: some View {
        SeminarInfoView(seminar: SeminarStore().seminarStore[0])
    }
}
