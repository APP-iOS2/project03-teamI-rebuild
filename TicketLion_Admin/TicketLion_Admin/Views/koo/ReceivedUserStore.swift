//
//  ReceivedUserStore.swift
//  TicketLion_Admin
//
//  Created by 임병구 on 2023/09/13.
//
import Foundation
import FirebaseFirestore

class UserListStore: ObservableObject {
    let dbRef = Firestore.firestore()
    @Published var userList: [User]
    //@Published var usersFromFirebase: [User] = []
    
    let currentDate = Date().timeIntervalSince1970
    
    init() {
        self.userList = []
    }
    
    func fetch(attendUsers: [String]){
        userList.removeAll()
        
        dbRef.collection("users").getDocuments { (snapshot, error) in
            guard error == nil else {
                print("error", error ?? "")
                return
            }

            if let snapshot = snapshot {
                for document in snapshot.documents {
                    if let jsonData = try? JSONSerialization.data(withJSONObject: document.data(), options: []),
                       let userData = try? JSONDecoder().decode(User.self, from: jsonData) {
                        let userEmail = userData.email
                        
                        if attendUsers.contains(userEmail) {
                            self.userList.append(userData)
                        }
                    }
                }
            }
        }
    }
}



