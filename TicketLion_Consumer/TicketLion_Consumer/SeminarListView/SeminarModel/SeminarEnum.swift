//
//  SeminarEnum.swift
//  TicketLion_Comsumer
//
//  Created by 이재승 on 2023/09/06.
//

enum Category: Int, CaseIterable {
    case FrontEnd
    case BackEnd
    case iOSDevelop
    case AndroidDevelop
    case etc
    
    var categoryName: String {
        switch self {
        case .FrontEnd : return "Front-End"
        case .BackEnd : return "Back-End"
        case .iOSDevelop : return "iOS Dev"
        case .AndroidDevelop : return "Android Dev"
        case .etc : return "etc"
        }
    }
}
