//
//  SettingSignUpCompleteView.swift
//  TicketLion_Comsumer
//
//  Created by 김윤우 on 2023/09/06.
//

import SwiftUI

struct SettingSignUpCompleteView: View {
    
    @EnvironmentObject var userStore: UserStore
    @EnvironmentObject var router: Router
    
//    @Binding var isCompleteSignUp: Bool
    
    var body: some View {
        NavigationStack(path: $router.path) {
            
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
                            Text("이름 : \(userStore.name)")
                            Divider()
                            Text("이메일 아이디 : \(userStore.email)")
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
//                        isCompleteSignUp.toggle()
                        router.reset()
                    } label: {
                        Text("확인")
                            .frame(maxWidth:.infinity, maxHeight: 50)
                            .foregroundColor(.white)
                            .background(Color("AnyButtonColor"))
                            .cornerRadius(5)
                    }

//                    .navigationDestination(isPresented: $isCompleteSignUp, destination: {
//                        SettingLoginView()}
//                    )

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
            SettingSignUpCompleteView(/* isCompleteSignUp: .constant(false) */ )
                .environmentObject(Router())
        }
    }
}
