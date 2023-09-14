//
//  UserInfo.swift
//  TicketLion_Admin
//
//  Created by 임병구 on 2023/09/13.
//

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
import FirebaseFirestoreSwift

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
    
    @Published var loginSheet: Bool = false
    
    var db = Firestore.firestore()
    
    
    
    
    // 
    
    
//    func signUpUser(name: String, email: String, password: String, phoneNumber: String, birth: String) {
//        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
//            if let error = error {
//                print("회원가입 실패: \(error.localizedDescription)")
//            } else if (authResult?.user) != nil {
//                // 회원가입 성공
//                let user = User(name: name, phoneNumber: phoneNumber, email: email, password: password, birth: birth, appliedSeminars: [], favoriteSeminars: [], recentlySeminars: [], canceledSeminars: [])
//
//                let userDictionary: [String: Any] = [
//                    "name": user.name,
//                    "phoneNumber": user.phoneNumber,
//                    "email": user.email,
//                    "password": user.password,
//                    "birth": user.birth,
//                    "appliedSeminars": user.appliedSeminars,
//                    "favoriteSeminars": user.favoriteSeminars,
//                    "recentlySeminars": user.recentlySeminars,
//                    "canceledSeminars": user.canceledSeminars
//                ]
//
//                // Firestore에 데이터 추가 (이메일을 문서 ID로 사용)
//                let db = Firestore.firestore()
//                db.collection("users").document(email).setData(userDictionary) { error in
//                    if error != nil {
//                        print("회원가입 실패")
//                    } else {
//                        self.isCompleteSignUp = true
//                    }
//                }
//            }
//        }
//    }
    
    
    // 사용자 정보 가져오기
    
    func fetchUserInfo(completion: @escaping (Bool) -> Void) {
        guard let currentUser = currentUser else {
            completion(false) // 현재 사용자가 없을 경우 데이터 가져오기 실패
            return
        }
        
        let userRef = db.collection("users").document(currentUser.email ?? currentUser.uid)
        
        userRef.getDocument { (document, error) in
            if let document = document, document.exists {
                if let userData = document.data(),
                   let user = try? JSONDecoder().decode(User.self, from: JSONSerialization.data(withJSONObject: userData)) {
                    // 유저 데이터를 필요한 형식으로 가공할 수 있습니다.
                    // 예: user.birth = user.birth.detailcalculateDate(date: user.birthValue)
                    self.name = user.name
                    self.phoneNumber = user.phoneNumber
                    self.favoriteSeminars = user.favoriteSeminars
                    self.appliedSeminars = user.appliedSeminars
                    self.recentlySeminars = user.recentlySeminars
                    self.canceledSeminars = user.canceledSeminars
                    self.email = user.email
                    self.birth = user.birth
                    
                    completion(true) // 데이터 가져오기 성공 시 true를 전달
                } else {
                    print("사용자 데이터 디코딩 실패")
                    completion(false) // 데이터 디코딩 실패 시 false를 전달
                }
            } else {
                print("사용자 정보를 불러오는 중 오류가 발생했습니다.")
                completion(false) // 데이터 가져오기 실패 시 false를 전달
            }
        }
    }

// 주석처리 위에 fetchUserInfo()로 변경
//    func fetchUserInfo() {
//        guard let currentUser = currentUser else {
//            return
//        }
//
//        let userRef = db.collection("users").document(currentUser.email ?? currentUser.uid)
//
//        userRef.getDocument { (document, error) in
//            if let document = document, document.exists {
//                let userData = document.data()
//                self.name = userData?["name"] as? String ?? ""
//                self.phoneNumber = userData?["phoneNumber"] as? String ?? ""
//                self.favoriteSeminars = userData?["favoriteSeminars"] as? [String] ?? []
//                self.appliedSeminars = userData?["appliedSeminars"] as? [String] ?? []
//                self.recentlySeminars = userData?["recentlySeminars"] as? [String] ?? []
//                self.canceledSeminars = userData?["canceledSeminars"] as? [String] ?? []
//                self.email = userData?["email"] as? String ?? ""
//                self.birth = userData?["birth"] as? String ?? ""
//            } else {
//                print("사용자 정보를 불러오는 중 오류가 발생했습니다.")
//            }
//        }
//    }
    
    
    
    
    //MARK: - 세미나 List 함수
    
    func addFavoriteSeminar(seminarID: String) {
        guard let currentUser = currentUser else {
            return
        }
        
        let userRef = db.collection("users").document(currentUser.email ?? currentUser.uid)

        userRef.updateData([
            "favoriteSeminars" : favoriteSeminars + [seminarID]
        ]) { err in
            if let err = err {
                print("\(err.localizedDescription)")
            } else { print("") }
        }
        
        userRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let userData = document.data()
                self.favoriteSeminars = userData?["favoriteSeminars"] as? [String] ?? []
            } else {
                print("사용자 정보를 불러오는 중 오류가 발생했습니다.")
            }
        }
        
    }
    
    func removeFavoriteSeminar(seminarID: String) {
        guard let currentUser = currentUser else {
            return
        }
        
        let userRef = db.collection("users").document(currentUser.email ?? currentUser.uid)
        
        userRef.updateData([
            "favoriteSeminars" : favoriteSeminars.filter { $0 != seminarID }
        ]) { err in
            if let err = err {
                print("\(err.localizedDescription)")
            } else { print("") }
        }
        
        userRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let userData = document.data()
                self.favoriteSeminars = userData?["favoriteSeminars"] as? [String] ?? []
            } else {
                print("사용자 정보를 불러오는 중 오류가 발생했습니다.")
            }
        }
    }
    
    func addSeminar(seminarID: String) {
        
        guard let currentUser = currentUser else {
            return
        }
        //appliedSeminars
        
        let userRef = db.collection("users").document(currentUser.email ?? currentUser.uid)
        
        userRef.updateData([
            "appliedSeminars" : appliedSeminars + [seminarID]
        ]) { err in
            if let err = err {
                print("\(err.localizedDescription)")
            } else { print("") }
        }
        
        userRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let userData = document.data()
                self.appliedSeminars = userData?["appliedSeminars"] as? [String] ?? []
            } else {
                print("사용자 정보를 불러오는 중 오류가 발생했습니다.")
            }
        }
        
    }
    
    
    
    
}


