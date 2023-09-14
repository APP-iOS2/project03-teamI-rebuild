//
//  DetailSidebar.swift
//  TicketLion_Admin
//
//  Created by 최세근 on 2023/09/06.
//

import SwiftUI

enum DetailSidebar: CaseIterable {
    case detail, attend
    
    var id: Self { self }
    
    var subtitles: [String] {
        switch self {
        case .detail :
            return ["상세 정보"]
        case .attend:
            return ["참석 목록"]
        }
    }
}

extension DetailSidebar: Identifiable {
    @ViewBuilder
    var label: some View {
        switch self {
        case .detail :
            
            Label("상세 정보", systemImage: "exclamationmark.octagon.fill")

        case .attend:
            Label("참석 목록", systemImage: "eye.slash.fill")
        }
    }
}
