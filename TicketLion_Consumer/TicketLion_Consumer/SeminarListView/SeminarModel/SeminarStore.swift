//
//  SeminarStore.swift
//  TicketLion_Consumer
//
//  Created by 이재승 on 2023/09/12.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

final class SeminarStore: ObservableObject {
    
    let db = Firestore.firestore()
    
    @Published var seminarList: [Seminar] = []
    
    func fetchSeminar() {
        
        db.collection("Seminar").getDocuments { snapshot, error in
            guard let documents = snapshot?.documents, error == nil else {
                if let error = error { print(error) }
                return
            }
            
            var fetchData = [Seminar] ()
            
            for document in documents {
                do {
                    let temp = try document.data(as: Seminar.self)
                    fetchData.append(temp)
                } catch {
                    print("파베 패치 에러 났어요.\n\(error)")
                }
            }
            self.seminarList = fetchData
        }
    }
	
	// 유저정보 이메일 -> database
    
    @MainActor
    func addUserPhoneNumberInSeminar(seminar: Seminar, userEmail: String) {
        
        let seminarRef = db.collection("Seminar").document("\(seminar.id)")
        
        seminarRef.updateData([
            "enterUsers" : seminar.enterUsers + [userEmail]
        ]) { err in
            if let err = err {
                print("\(err.localizedDescription)")
            } else { print("") }
        }
        
        fetchSeminar()
        
    }
	
}

