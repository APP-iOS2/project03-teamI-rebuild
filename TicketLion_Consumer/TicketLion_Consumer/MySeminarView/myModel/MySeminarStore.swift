//
//  MySeminarStore.swift
//  TicketLion_Comsumer
//
//  Created by Muker on 2023/09/07.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

final class MySeminarStore: ObservableObject {
    
    let db = Firestore.firestore()
    
    //MySeminarView
    @Published var isPresentDetailSeminar: Bool = false
    @Published var navigationPath: [Seminar] = []
    @Published var seminarList: [Seminar] = []
    
    //MyReservationView
    @Published var selectedSeminar: Seminar = Seminar.TempSeminar
	@Published var isShowingSheet = false
	@Published var showingToast = false
    
    //MyFavoriteView
    
    //MyTicketSheetView
    
    
    func fetchSeminar() {
        
        db.collection("Seminar").getDocuments { snapshot, error in
            guard let documents = snapshot?.documents, error == nil else {
                if let error = error { print(error) }
                return
            }
            
            var fetchData = [Seminar]()
            
            for document in documents {
                do {
                    let temp = try document.data(as: Seminar.self)
                    fetchData.append(temp)
                    
                } catch {
                    print("\(error)")
                }
            }
            
            self.seminarList = fetchData

        }
    }
    
    func timeCreator(_ time: Double) -> String {
        let createdAt: Date = Date(timeIntervalSince1970: time)
        let fomatter: DateFormatter = DateFormatter()
        fomatter.dateFormat = "hh:mm a"
        
        return fomatter.string(from: createdAt)
    }
    
    func dateCreator(_ time: Double) -> String {
        let createdAt: Date = Date(timeIntervalSince1970: time)
        let fomatter: DateFormatter = DateFormatter()
        fomatter.dateFormat = "yyyy년 MM월 dd일"
        
        return fomatter.string(from: createdAt)
    }
    
}

