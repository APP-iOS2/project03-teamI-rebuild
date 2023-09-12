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
    @Published var isCompleteSignUp = false
    @Published var errorMessage = ""

    // Firebase에 사용자 등록
    func signUpUser(name: String, email: String, password: String, phoneNumber: String, birth: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
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
                    if let error = error {
                        self.errorMessage = "회원가입 중 오류가 발생했습니다."
                    } else {
                        self.isCompleteSignUp = true
                    }
                }
            }
        }
    }

}

