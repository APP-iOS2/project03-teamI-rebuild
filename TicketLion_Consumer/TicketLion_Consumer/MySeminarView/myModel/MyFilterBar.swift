//
//  MyFilterEnum.swift
//  TicketLion_Comsumer
//
//  Created by Muker on 2023/09/06.
//

import Foundation

enum MyFilterBar: Int, CaseIterable {
    case reservation
    case favorite
    
    var title: String {
        switch self {
        case .reservation: return "예매내역"
        case .favorite: return "즐겨찾기"
        }
    }
}
