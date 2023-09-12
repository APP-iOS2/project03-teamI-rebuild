//
//  SettingUserDetailView.swift
//  TicketLion_Comsumer
//
//  Created by 이승준 on 2023/09/11.
//

import SwiftUI

struct SettingUserDetailView: View {
    
    @ObservedObject var userStore: UserStore
    
    var body: some View {
        VStack {
             Form {
                 Section {
                     HStack {
                         AsyncImage(url: URL(string: "https://i.namu.wiki/i/y7qTOOIL6nIa2cXybk511OASqwAGMgZiNjh6CtErz0ust7MPJaztzSYiypYevehQOjdJc-TQvTctUk7N629V7A.webp")) { image in
                             image
                                 .resizable()
                                 .aspectRatio(contentMode: .fit)
                                 .background(.gray)
                                 .clipShape(Circle())
                                 .frame(width: 100, height: 100)
                         } placeholder: {
                             ProgressView()
                         }
                         
                         VStack(alignment: .leading) {
                             Text(userStore.name)
                                 .font(.title)
                                 .bold()
                             Text(userStore.phoneNumber)
                             Text(userStore.email)
                             Text(userStore.birth)
                         }
                     }
                 }
                 Section("신청한 세미나") {
                     ForEach(userStore.appliedSeminars, id: \.self) { appliedSeminar in
                         Text(appliedSeminar)
                     }
                 }
                 Section("즐겨찾기한 세미나") {
                     ForEach(userStore.favoriteSeminars, id: \.self) { favoriteSeminar in
                         Text(favoriteSeminar)
                     }
                 }
                 Section("최근 본 세미나") {
                     ForEach(userStore.recentlySeminars, id: \.self) { recentlySeminar in
                         Text(recentlySeminar)
                     }
                 }
                 Section("취소한 세미나") {
                     ForEach(userStore.canceledSeminars, id: \.self) { canceledSeminar in
                         Text(canceledSeminar)
                     }
                 }
            }
        }
        .navigationTitle("계정 정보")
    }
}

struct SettingUserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingUserDetailView(userStore: UserStore())
        }
    }
}
