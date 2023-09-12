//
//  SettingUserView.swift
//  TicketLion_Comsumer
//
//  Created by 이승준 on 2023/09/11.
//

import SwiftUI

struct SettingUserView: View {
    var user: User = User.usersDummy[0]
    
    var body: some View {
        
        HStack {
            Image("")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .background(.gray)
                .clipShape(Circle())
                .frame(width: 75, height: 75)
            VStack(alignment: .leading) {
                Text(user.name)
                    .font(.title2)
                    .bold()
                Text(user.phoneNumber)
                Text(user.email)
                Text(user.birth)
            }
        }
    }
}

struct SettingUserView_Previews: PreviewProvider {
    static var previews: some View {
        SettingUserView()
    }
}
