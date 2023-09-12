//
//  SettingUserView.swift
//  TicketLion_Comsumer
//
//  Created by 이승준 on 2023/09/11.
//

import SwiftUI

struct SettingUserView: View {
    
    @ObservedObject var userStore: UserStore
    
    var body: some View {
        
        HStack {
            Image("")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .background(.gray)
                .clipShape(Circle())
                .frame(width: 75, height: 75)
            VStack(alignment: .leading) {
                Text(userStore.name)
                    .font(.title2)
                    .bold()
                Text(userStore.phoneNumber)
                Text(userStore.email)
                Text(userStore.birth)
            }
        }
    }
}

struct SettingUserView_Previews: PreviewProvider {
    static var previews: some View {
        SettingUserView(userStore: UserStore())
    }
}
