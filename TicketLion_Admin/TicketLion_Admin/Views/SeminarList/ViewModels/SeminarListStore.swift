//
//  SeminalListStore.swift
//  TicketLion_Admin
//
//  Created by 아라 on 2023/09/06.
//

import Foundation
import FirebaseFirestore

class SeminarListStore: ObservableObject {
    @Published var seminarList: [Seminar]
    @Published var isLoading = false
    
    let dbRef = Firestore.firestore()
    
    let currentDate = Date().timeIntervalSince1970
    
    var recruitingList: [Seminar] {
        seminarList.filter { $0.registerEndDate >= currentDate && !$0.closingStatus}
    }
    
    var closedList: [Seminar] {
        seminarList.filter { $0.registerEndDate < currentDate || $0.closingStatus}
    }
    
    init() {
        self.seminarList = []
    }
    
    func fetch() {
        isLoading = false
        seminarList.removeAll()
        
        dbRef.collection("Seminar").getDocuments { (snapshot, error) in
            guard error == nil else {
                print("error", error ?? "")
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    if let jsonData = try? JSONSerialization.data(withJSONObject: document.data(), options: []),
                       let seminarData = try? JSONDecoder().decode(Seminar.self, from: jsonData) {
                        self.seminarList.append(seminarData)
                    }
                }
                self.isLoading = true
            }
        }
        
        self.seminarList.sort { $0.createdAt > $1.createdAt }
    }
    
    func calculateDate(date: Double) -> String {
        let date = Date(timeIntervalSince1970: date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy.MM.dd"
        return dateFormatter.string(from: date)
    }
    
    func selectSeminar(id: String) -> Seminar? {
        seminarList.first { $0.id == id }
    }
}
