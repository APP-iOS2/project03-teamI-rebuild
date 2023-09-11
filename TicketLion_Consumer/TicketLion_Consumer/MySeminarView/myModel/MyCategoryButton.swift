//
//  MyCategoryEnum.swift
//  TicketLion_Comsumer
//
//  Created by Muker on 2023/09/06.
//

import Foundation

enum MyCategoryButton: Int, CaseIterable {
    case whole
    case reservation
    case cancel
    
    var title: String {
        switch self {
        case .whole: return "전체"
        case .reservation: return "예약완료"
        case .cancel: return "예매취소"
        }
    }
}
