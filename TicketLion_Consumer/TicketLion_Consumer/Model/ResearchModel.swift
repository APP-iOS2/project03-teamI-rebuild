//
//  ResearchModel.swift
//  TicketLion_Comsumer
//
//  Created by 김종찬 on 2023/09/11.
//

import Foundation

struct Research: Identifiable {
    
    let id: String = UUID().uuidString
    /// 설문을 실시했던 세미나 ID
    let seminarID: String
    /// 설문에 참여한 유저ID
    let userID: String
    /// 첫번째 설문 응답
    let answer1: Bool
    /// 두번째 설문 응답
    let answer2: Bool
    
}
