//
//  SeminarSidebarCell.swift
//  TicketLion_Admin
//
//  Created by 최세근 on 2023/09/06.
//

import SwiftUI

struct SeminarSidebarCell: View {
    var title: String
//    var count: Int
    
    var body: some View {
        HStack {
            Text(title)
//            Spacer()
//            Text("\(count)")
        }
        .font(.title3)
    }
}

struct SeminarSidebarCell_Previews: PreviewProvider {
    static var previews: some View {
        SeminarSidebarCell(title: "Text")
    }
}
