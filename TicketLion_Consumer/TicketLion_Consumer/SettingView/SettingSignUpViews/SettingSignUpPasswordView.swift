//
//  SettingSignUpPasswordView.swift
//  TicketLion_Comsumer
//
//  Created by 김윤우 on 2023/09/06.
//

import SwiftUI

struct SettingSignUpPasswordView: View {
    @EnvironmentObject var userStore: UserStore
//    @Binding var isCompleteSignUp: Bool
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 25 ) {
                Divider()
                    .background(Color("AnyButtonColor"))
                
                HStack {
                    Text("로그인시 사용할\n") +
                    Text("비밀번호").fontWeight(.bold) +
                    Text("를 입력해주세요")
                    
                    Spacer()
                    
                    Text("2/5")
                }
                .font(.title2)
                
                SecureField("비밀번호 입력", text: $userStore.password)
                    .padding()
                    .background(Color(uiColor: .secondarySystemBackground))
                    .cornerRadius(5)
                
                SecureField("비밀번호 확인", text: $userStore.passwordCheck)
                    .padding()
                    .background(Color(uiColor: .secondarySystemBackground))
                    .cornerRadius(5)
                
                Group {
                    // 비밀번호 유효성 검사
                    if !userStore.isPasswordValid {
                        Text("비밀번호는 최소 6자 이상 포함해야 합니다.")
                            .foregroundColor(.red)
                    }
                    
                    // 비밀번호 일치 여부 검사
                    if !userStore.passwordsMatch {
                        Text("비밀번호가 일치하지 않습니다.")
                            .foregroundColor(.red)
                    }
                }
                .font(.subheadline)
                
                NavigationLink {
                    SettingSignUpNameView(/* isCompleteSignUp: $isCompleteSignUp*/)
                } label: {
                    Text("다음")
                }
                .frame(maxWidth: .infinity, maxHeight: 20)
                .padding()
                .font(.title2)
                .foregroundColor(.white)
                .background(userStore.isPasswordValid && userStore.passwordsMatch ? Color("AnyButtonColor") : Color.gray)
                .cornerRadius(5)
                .disabled(!userStore.isPasswordValid || !userStore.passwordsMatch)
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
        NavigationStack {
            SettingSignUpPasswordView(/* isCompleteSignUp: .constant(false)*/)
        }
    }
}

