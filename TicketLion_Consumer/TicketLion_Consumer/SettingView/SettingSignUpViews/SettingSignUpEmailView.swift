//
//  SettingSignUpEmailView.swift
//  TicketLion_Comsumer
//
//  Created by 김윤우 on 2023/09/06.
//

import SwiftUI

struct SettingSignUpEmailView: View {
    @State private var email: String = ""
    
    @Binding var isCompleteSignUp: Bool
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading, spacing: 25 ){
                
                Divider()
                    .background(Color("AnyButtonColor"))
                
                HStack{
                    Text("로그인시 사용할\n") +
                    Text("이메일 아이디").fontWeight(.bold) +
                    Text("를 입력해주세요")

                    Spacer()
                    
                    Text("1/5")
                    }
                    .font(.title2)

                    TextField("사용하실 이메일 아이디를 입력해주세요.", text: $email)
                    .padding()
                    .background(Color(uiColor: .secondarySystemBackground))
                    .cornerRadius(5)
                
                NavigationLink {
                    SettingSignUpPasswordView(isCompleteSignUp: $isCompleteSignUp)
                } label: {
                    
                    Text("다음")
                }
                .frame(maxWidth: .infinity, maxHeight: 20)
                .padding()
                .font(.title2)
                .foregroundColor(.white)
                .background(email.isEmpty ?  Color.gray : Color("AnyButtonColor"))
                .cornerRadius(5)
                .disabled(email.isEmpty)
                
            }
            .padding()
            .navigationTitle("회원가입")
            .navigationBarTitleDisplayMode(.inline)
            
            Spacer()
            
        }
    }
    
}

struct SettingSignUpEmailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            SettingSignUpEmailView(isCompleteSignUp: .constant(false))
        }
    }
}
