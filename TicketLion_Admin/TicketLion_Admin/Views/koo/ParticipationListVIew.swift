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
    @ObservedObject private var userListStore: UserListStore = UserListStore()
    @State private var selectedLeftlist: Classification?
    @State private var searchText = ""
    @State private var isAscendingOrder = true //정렬
    let selectedUsers: [String]

    var filteredUsers: [User] {
        if searchText.isEmpty {
            return userListStore.userList
        } else {
            return userListStore.userList.filter { user in
                return user.name.localizedCaseInsensitiveContains(searchText) ||
                user.phoneNumber.localizedStandardContains(searchText) ||
                user.email.localizedStandardContains(searchText)
            
            }
        }
    }
    
    var sortedUsersByName: [User] {
        return filteredUsers.sorted(by: { user1, user2 in
            if isAscendingOrder {
                return user1.name < user2.name
            } else {
                return user1.name > user2.name
            }
        })
    }
    
    var body: some View {
        VStack{
            HStack{
             Image(systemName: "magnifyingglass")
                TextField("검색어 입력", text: $searchText)
                    .padding(4)
                
                Button(action: {
                           // 버튼 클릭 시 정렬 방향 변경
                           isAscendingOrder.toggle()
                       }) {
                           Text("이름 정렬")
                           Image(systemName: isAscendingOrder ? "arrow.down" : "arrow.up")
                       }
                   }
                    
       
            .padding(.horizontal,15)
            Rectangle()
                .frame(width: UIScreen.main.bounds.width * 0.98, height: 0.5)
            
            
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
                ForEach(sortedUsersByName) { user in
                    TableRow(user)
                }
            }
            
        }
        .onAppear {
            userListStore.fetch(attendUsers: selectedUsers)
        }
    }
}


struct ParticipationListVIew_Previews: PreviewProvider {
    static var previews: some View {
        ParticipationListVIew(selectedUsers: [])
    }
}
