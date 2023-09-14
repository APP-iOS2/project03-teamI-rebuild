//
//  SettingUserDetailView.swift
//  TicketLion_Comsumer
//
//  Created by 이승준 on 2023/09/11.
//

import SwiftUI

struct SettingUserDetailView: View {
    
    @EnvironmentObject var userStore: UserStore
    
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
                            Text(userStore.email)
                            Text(userStore.phoneNumber)
                            Text(userStore.birth)
                        }
                    }
                }
                Section("신청한 세미나") {
                    if userStore.appliedSeminarDetails.count == 0 {
                        Text("신청한 세미나가 없습니다")
                    } else {
                        ForEach(userStore.appliedSeminarDetails, id: \.self) { appliedSeminar in
                            Text(appliedSeminar.name)
                        }
                    }
                }
                Section("즐겨찾기한 세미나") {
                    if userStore.favoriteSeminarDetails.count == 0 {
                        Text("즐겨찾기한 세미나가 없습니다")
                    } else {
                        ForEach(userStore.favoriteSeminarDetails, id: \.self) { favoriteSeminar in
                            Text(favoriteSeminar.name)
                        }
                    }
                }
                Section("취소한 세미나") {
                    if userStore.canceledSeminarDetails.count == 0 {
                        Text("취소한 세미나가 없습니다")
                    } else {
                        ForEach(userStore.canceledSeminarDetails, id: \.self) { canceledSeminar in
                            Text(canceledSeminar.name)
                        }
                    }
                }
            }
        }
        .navigationTitle("계정 정보")
        .onAppear {
            userStore.updateSeminarDetails()
        }
        
    }
}

struct SettingUserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingUserDetailView().environmentObject(UserStore())
        }
    }
}
