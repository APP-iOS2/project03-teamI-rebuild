//
//  MainView.swift
//  TicketLion_Admin
//
//  Created by 김종찬 on 2023/09/05.
//

import SwiftUI

struct MainView: View {
    @State var columnVisibility = NavigationSplitViewVisibility.doubleColumn
    @ObservedObject var seminarStore: SeminarListStore
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            SeminarSideView(seminarStore: seminarStore)
        } detail: {
            WholeListView(seminarStore: seminarStore)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(seminarStore: SeminarListStore())
    }
}
