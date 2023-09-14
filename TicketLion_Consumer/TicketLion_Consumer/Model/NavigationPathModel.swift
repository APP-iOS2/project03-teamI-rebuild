//
//  NavigationPathModel.swift
//  TicketLion_Consumer
//
//  Created by 김윤우 on 2023/09/13.
//

import SwiftUI

class Router: ObservableObject {
    @Published var path = NavigationPath()
    
    func reset() {
        path = NavigationPath()
    }
    
   
}
