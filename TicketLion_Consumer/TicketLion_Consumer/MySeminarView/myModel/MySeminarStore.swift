//
//  MySeminarStore.swift
//  TicketLion_Comsumer
//
//  Created by Muker on 2023/09/07.
//

import SwiftUI

final class MySeminarStore: ObservableObject {
    
    //MySeminarView
    @Published var isPresentDetailSeminar: Bool = false
    @Published var navigationPath: [Seminar] = []
    
    //MyReservationView
    @Published var selectedSeminar: Seminar = Seminar.TempSeminar
    
    //MyFavoriteView
    
    //MyTicketSheetView
    
}

