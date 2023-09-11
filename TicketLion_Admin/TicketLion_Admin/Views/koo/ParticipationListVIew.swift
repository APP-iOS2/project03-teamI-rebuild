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
    
    let data = Array(1...100).map {" 목록 \($0)"}
    
    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    let data2 = [
            "이름 1", "생년월일 1", "전화번호 1", "상태 1",
            "이름 2", "생년월일 2", "전화번호 2", "상태 2",
            // 데이터 계속 추가
        ]

    
    
    let people = [
        User(name: "임병구", phoneNumber: "010-1111-1112", email: "b_9@kk.com", password: "1q2w3e4r", birth: "6/22", appliedSeminars: ["a1","a2"], favoriteSeminars: ["k1","k2"], recentlySeminars: ["c1","c2"], canceledSeminars: ["d1","d2"]),
        User(name: "나예슬", phoneNumber: "010-1111-1222", email: "a2f@kk.com", password: "1q2w3e4r", birth: "1/22", appliedSeminars: ["a1","a2"], favoriteSeminars: ["k1","k2"], recentlySeminars: ["c1","c2"], canceledSeminars: ["d1","d2"]),
        User(name: "선아라", phoneNumber: "010-1141-1142", email: "sdfg@kk.com", password: "1q2w3e4r", birth: "2/02", appliedSeminars: ["a1","a2"], favoriteSeminars: ["k1","k2"], recentlySeminars: ["c1","c2"], canceledSeminars: ["d1","d2"]),
        User(name: "최세근", phoneNumber: "010-1141-1542", email: "bsff@kk.com", password: "1q2w3e4r", birth: "3/22", appliedSeminars: ["a1","a2"], favoriteSeminars: ["k1","k2"], recentlySeminars: ["c1","c2"], canceledSeminars: ["d1","d2"]),
        User(name: "이승준", phoneNumber: "010-1711-1112", email: "s4@kk.com", password: "1q2w3e4r", birth: "6/52", appliedSeminars: ["a1","a2"], favoriteSeminars: ["k1","k2"], recentlySeminars: ["c1","c2"], canceledSeminars: ["d1","d2"]),
        User(name: "유재희", phoneNumber: "010-1412-1112", email: "bsfg@kk.com", password: "1q2w3e4r", birth: "10/22", appliedSeminars: ["a1","a2"], favoriteSeminars: ["k1","k2"], recentlySeminars: ["c1","c2"], canceledSeminars: ["d1","d2"]),
        User(name: "김윤우", phoneNumber: "010-1151-185", email: "bhs@kk.com", password: "1q2w3e4r", birth: "6/22", appliedSeminars: ["a1","a2"], favoriteSeminars: ["k1","k2"], recentlySeminars: ["c1","c2"], canceledSeminars: ["d1","d2"])
    
    
    ]
    
    @State private var selectedLeftlist: Classification?
    
    
    
    var body: some View {
        NavigationSplitView {
            List(Classification.allCases,id: \.self, selection: $selectedLeftlist) { leftlist in
                NavigationLink(leftlist.rawValue, value: leftlist)
            }
            .font(.title)
            .fontWeight(.semibold)
//        } content: {
//            Text("content")
        } detail: {
            Text(selectedLeftlist?.rawValue ?? "")
            
         
//
        

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

            
            

            
            
//                ScrollView {
//                    LazyVGrid(columns: columns,spacing:20){
//                        ForEach(data, id: \.self) { i in
//                            Text(i)
//
//
//                    }
//                }
//
//
//
//        }
            // Detail view for each ofr the sub-menu item
        }
    }
}

struct ParticipationListVIew_Previews: PreviewProvider {
    static var previews: some View {
        ParticipationListVIew()
    }
}
