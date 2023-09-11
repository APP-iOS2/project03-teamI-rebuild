//
//  SettingSignUpPasswordView.swift
//  TicketLion_Comsumer
//
//  Created by 김윤우 on 2023/09/06.
//

import SwiftUI

struct SettingSignUpPasswordView: View {
    @State private var password: String = ""
    @State private var passwordCheck: String = ""
    
    @Binding var isCompleteSignUp: Bool
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading, spacing: 25 ){
                
                Divider()
                    .background(Color("AnyButtonColor"))
                
                HStack{
                    Text("로그인시 사용할\n") +
                    Text("비밀번호").fontWeight(.bold) +
                    Text("를 입력해주세요")
                    
                    Spacer()
                    
                    Text("2/5")
                }
                .font(.title2)
                
                SecureField("비밀번호 입력", text: $password)
                    .padding()
                    .background(Color(uiColor: .secondarySystemBackground))
                    .cornerRadius(5)
                
                SecureField("비밀번호 확인", text: $passwordCheck)
                    .padding()
                    .background(Color(uiColor: .secondarySystemBackground))
                    .cornerRadius(5)
                
                
                NavigationLink {
                    SettingSignUpNameView(isCompleteSignUp: $isCompleteSignUp)
                } label: {
                    
                    Text("다음")
                }
                .frame(maxWidth: .infinity, maxHeight: 20)
                .padding()
                .font(.title2)
                .foregroundColor(.white)
                .background(password.isEmpty ?  Color.gray : Color("AnyButtonColor"))
                .cornerRadius(5)
                .disabled(password.isEmpty || passwordCheck.isEmpty)
                
            }
            .padding()
            .navigationTitle("회원가입")
            .navigationBarTitleDisplayMode(.inline)
            
            Spacer()
            
        }
    }
    
}
struct SettingSignUpPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            SettingSignUpPasswordView(isCompleteSignUp: .constant(false))
        }
    }
}
