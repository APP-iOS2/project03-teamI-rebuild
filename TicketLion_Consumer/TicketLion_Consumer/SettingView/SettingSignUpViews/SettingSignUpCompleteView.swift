//
//  SettingSignUpCompleteView.swift
//  TicketLion_Comsumer
//
//  Created by 김윤우 on 2023/09/06.
//

import SwiftUI

struct SettingSignUpCompleteView: View {
    
    @ObservedObject var signUpStore: SignUpStore
    
    @Binding var isCompleteSignUp: Bool
    
    var body: some View {
        NavigationStack {
            
            VStack {
                
                Divider()
                    .background(Color("AnyButtonColor"))
                
                Spacer()
                Label("완료 심볼", systemImage: "checkmark.circle.fill")
                    .labelStyle(IconOnlyLabelStyle())
                    .font(.system(size: 80))
                    .foregroundColor(Color("AnyButtonColor"))
                    .padding()
                
                Group {
                    Text("반갑습니다!")
                    Text("회원가입이 완료되었습니다!")
                }
                .font(.title2)
                
                Spacer()
                
                VStack(spacing: 20) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("이름 : \(signUpStore.name)")
                            Divider()
                            Text("이메일 아이디 : \(signUpStore.email)")
                        }
                        .padding()
                        .foregroundColor(.black)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    
                    Button {
                        isCompleteSignUp.toggle()
                    } label: {
                        Text("확인")
                    }
                    .navigationDestination(isPresented: $isCompleteSignUp, destination: {
                        SettingLoginView()
                    })
                    .frame(maxWidth:.infinity, maxHeight: 50)
                    .foregroundColor(.white)
                    .background(Color("AnyButtonColor"))
                    .cornerRadius(5)
                }
                Spacer()
            }
            .padding()
            
            .navigationTitle("회원가입")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SettingSignUpCompleteView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            SettingSignUpCompleteView(signUpStore: SignUpStore(), isCompleteSignUp: .constant(false))
        }
    }
}
