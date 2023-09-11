//
//  SettingSignUpNameView.swift
//  TicketLion_Comsumer
//
//  Created by 김윤우 on 2023/09/06.
//

import SwiftUI

struct SettingSignUpNameView: View {
    @State private var name: String = ""
    
    @Binding var isCompleteSignUp: Bool
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading, spacing: 25 ){

                Divider()
                    .background(Color("AnyButtonColor"))
                
                HStack{
                    Text("이름").fontWeight(.bold) +
                    Text("을\n 입력해주세요 ")

                    Spacer()
                    Text("3/5")
                    }
                    .font(.title2)

                    TextField("이름 입력", text: $name)
                    .padding()
                    .background(Color(uiColor: .secondarySystemBackground))
                    .cornerRadius(5)
                
                NavigationLink {
                    SettingSignUpPhoneNumberView( isCompleteSignUp: $isCompleteSignUp)
                } label: {
                    
                    Text("다음")
                }
                .frame(maxWidth: .infinity, maxHeight: 20)
                .padding()
                .font(.title2)
                .foregroundColor(.white)
                .background(name.isEmpty ?  Color.gray : Color("AnyButtonColor"))
                .cornerRadius(5)
                .disabled(name.isEmpty)
                
            }
            .padding()
            .navigationTitle("회원가입")
            .navigationBarTitleDisplayMode(.inline)
            
            Spacer()
            
        }
    }
    
}

struct SettingSignUpNameView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingSignUpNameView(isCompleteSignUp: .constant(false))
        }
    }
}
