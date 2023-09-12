//
//  SignUpStore.swift
//  TicketLion_Consumer
//
//  Created by 김윤우 on 2023/09/12.
//

import Foundation
import SwiftUI

final class SignUpStore: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var passwordCheck: String = ""
    @Published var name: String = ""
    @Published var birth: String = ""
    @Published var phoneNumber: String = ""
    
    
    var passwordsMatch: Bool {
            // 두 비밀번호가 일치하는지 확인
            return password == passwordCheck
        }
    
    
    func isValidEmail() -> Bool {
        // [A-Z0-9a-z._%+-] 영어 대문자 소문자 특수문자까지 가능
        // @뒤에 대소문자 숫자만 가능
        // [A-Za-z] 영어 대소문자만 가능
        // {2, 30} 2~30글자까지만 허용
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.(com|co\\.kr|go\\.kr)"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    var isPasswordValid: Bool {
            // 비밀번호가 최소 8자 이상, 특수문자와 숫자를 포함하는지 확인
            let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*?&#])[A-Za-z\\d@$!%*?&#]{8,}$"
            let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
            return passwordPredicate.evaluate(with: password)
        }
    
    
    
}
