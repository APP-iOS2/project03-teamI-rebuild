//
//  SeminarDetail.swift
//  TicketLion_Admin
//
//  Created by 최세근 on 2023/09/06.
//

import SwiftUI

struct SeminarDetail: View {
    @State var columnVisibility = NavigationSplitViewVisibility.doubleColumn
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            SeminarDetailSidebar()
        } detail: {
            
        }
    }
}

struct SeminarDetail_Previews: PreviewProvider {
    static var previews: some View {
        SeminarDetail()
    }
}
