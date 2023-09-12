//
//  ParticipationListVIew.swift
//  TicketLion_Admin
//
//  Created by 임병구 on 2023/09/06.
//

import SwiftUI

enum Classification: String, Hashable, CaseIterable {
    case detailInfo = "상세정보"
    case attendanceList = "참석목록"
}

//
//struct MenuItem: Identifiable, Hashable {
//    var id = UUID()
//    var name: String
//    var image: String
//    var subMenuItems: [MenuItem]?
//}





struct ParticipationListVIew: View {
   
    @State private var selectedLeftlist: Classification?
    
    
    
    var body: some View {
        VStack{
            
            Table(of: User.self) {
                TableColumn("이름") { user in
                    Text(user.name)
                }
                TableColumn("생년월일") { user in
                    Text(user.birth)
                }
                TableColumn("전화번호") { user in
                    Text(user.phoneNumber)
                }
                TableColumn("상태") { user in
                    Text(user.email)
                }
            } rows: {
                ForEach(User.usersDummy) { user in
                    TableRow(user)
                }
            }
            
        }
    }
}


struct ParticipationListVIew_Previews: PreviewProvider {
    static var previews: some View {
        ParticipationListVIew()
    }
}
