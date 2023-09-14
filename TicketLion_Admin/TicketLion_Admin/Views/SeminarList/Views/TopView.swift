//
//  TopView.swift
//  TicketLion_Admin
//
//  Created by 아라 on 2023/09/14.
//

import SwiftUI

enum SeminarType: String {
    case whole = "sort whole list"
    case recruiting = "sort recruiting list"
}

struct TopView: View {
    @Binding var order: Order
    let type: SeminarType
    
    var body: some View {
        HStack {
            NavigationLink {
                SeminarAddView(seminarStore: SeminarStore(), chipsViewModel: ChipsViewModel())
            } label: {
                Text("세미나 등록하기")
                    .font(.title3).bold()
            }
            .padding(.leading, 15)
            
            Spacer()
            
            Picker(type.rawValue, selection: $order) {
                ForEach(Order.allCases, id:\.self) { order in
                    Text(order.rawValue)
                }
            }
            .pickerStyle(.menu)
            .padding(.trailing, 15)
        }
        .padding(.bottom, 10)
    }
}

//struct TopView_Previews: PreviewProvider {
//    static var previews: some View {
//        TopView(order: <#Binding<Order>#>, type: <#SeminarType#>)
//    }
//}
