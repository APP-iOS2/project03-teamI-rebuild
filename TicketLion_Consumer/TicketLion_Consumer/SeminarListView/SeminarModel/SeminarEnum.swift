//
//  SeminarEnum.swift
//  TicketLion_Comsumer
//
//  Created by 이재승 on 2023/09/06.
//

enum Category {
    case FrontEnd
    case BackEnd
    case iOSDevelop
    case AndroidDevelop
    
    var categoryName: String {
        switch self {
        case .FrontEnd : return "Front-End"
        case .BackEnd : return "Back-End"
        case .iOSDevelop : return "iOS Dev"
        case .AndroidDevelop : return "Android Dev"
        }
    }
}
