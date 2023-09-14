//
//  PageListView.swift
//  TicketLion_Admin
//
//  Created by 아라 on 2023/09/14.
//

import SwiftUI

struct PageListView: View {
    @Binding var currentPage: Int
    let totalPages: Int
    
    var body: some View {
        HStack {
            ForEach(1..<totalPages + 1, id: \.self) { num in
                Button {
                    currentPage = num
                } label: {
                    Text("\(num)")
                        .fontWeight(currentPage == num ? .bold : .regular)
                        .foregroundColor(currentPage == num ? .black : .gray)
                        .font(.headline)
                }
                .padding(.horizontal, 5)
            }
        }
    }
}

//struct PageListView_Previews: PreviewProvider {
//    static var previews: some View {
//        PageListView()
//    }
//}
