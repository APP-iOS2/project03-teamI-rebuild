//
//  UserStore.swift
//  TicketLion_Consumer
//
//  Created by Jaehui Yu on 2023/09/12.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

class UserStore: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var passwordCheck: String = ""
    @Published var name: String = ""
    @Published var birth: String = ""
    @Published var phoneNumber: String = ""
    @Published var appliedSeminars: [String] = []
    @Published var favoriteSeminars: [String] = []
    @Published var recentlySeminars: [String] = []
    @Published var canceledSeminars: [String] = []
    
    @Published var isCompleteSignUp = false
    
    @Published var currentUser: Firebase.User?


    func signUpUser(name: String, email: String, password: String, phoneNumber: String, birth: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("회원가입 실패: \(error.localizedDescription)")
            } else {
                // 회원가입 성공
                let user = User(name: name, phoneNumber: phoneNumber, email: email, password: password, birth: birth, appliedSeminars: [], favoriteSeminars: [], recentlySeminars: [], canceledSeminars: [])
                
                let userDictionary: [String: Any] = [
                    "name": user.name,
                    "phoneNumber": user.phoneNumber,
                    "email": user.email,
                    "password": user.password,
                    "birth": user.birth,
                    "appliedSeminars": user.appliedSeminars,
                    "favoriteSeminars": user.favoriteSeminars,
                    "recentlySeminars": user.recentlySeminars,
                    "canceledSeminars": user.canceledSeminars
                ]

                // Firestore에 데이터 추가
                let db = Firestore.firestore()
                db.collection("users").addDocument(data: userDictionary) { error in
                    if error != nil {
                        print("회원가입 실패")
                    } else {
                        self.isCompleteSignUp = true
                    }
                }
            }
        }
    }
    
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

    init() {
        currentUser = Auth.auth().currentUser
    }
    
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("error: \(error.localizedDescription)")
                return
            }
            self.currentUser = result?.user
        }
    }
    
    func logout() {
        currentUser = nil
        try? Auth.auth().signOut()
    }
    
    func autoLogin() {
            guard let currentUser = currentUser else { return }
        login(email: currentUser.email ?? "", password:"")
    }
    
}

