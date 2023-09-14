//
//  SettingLoginView.swift
//  TicketLion_Comsumer
//
//  Created by 이승준 on 2023/09/06.
//

import SwiftUI

struct SettingLoginView: View {
    @State private var userEmail: String = ""
    @State private var userPassword: String = ""
    @State private var loginFailedMessage: String = ""
//    @State private var isCompleteSignUp: Bool = false
    @EnvironmentObject var userStore: UserStore
    @EnvironmentObject var router: Router

    
    var body: some View {
        NavigationStack(path: $router.path) {
            VStack(spacing: 25) {
                Divider()
                    .background(Color("AnyButtonColor"))
                Spacer()
                Image("TicketLion")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .cornerRadius(20)
                Text(loginFailedMessage)
                    .foregroundColor(.red)
                TextField("이메일 입력", text: $userEmail)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 2)
                    )
					.textInputAutocapitalization(.never)
                
                SecureField("비밀번호 입력", text: $userPassword)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 2)
                    )
                
                Button {
					Task {
						do {
							try await userStore.login(email: userEmail, password: userPassword)
						} catch {
							
						}
						if userStore.currentUser != nil {
							userStore.loginSheet = false
                        } else {
                            loginFailedMessage = "이메일 또는 비밀번호가 틀렸습니다."
                        }
					}
                } label: {
                    Text("로그인")
                        .frame(maxWidth: .infinity, maxHeight: 20)
                        .padding()
                        .font(.title2)
                        .foregroundColor(.white)
                        .background(Color("AnyButtonColor"))
                        .cornerRadius(5)
                }
                
//                .navigationDestination(isPresented: $isLoggedinUser, destination: {
//                    SettingView()
//                })
                
                NavigationLink {
                    SettingSignUpEmailView(/*isCompleteSignUp: $isCompleteSignUp*/)
                    
                } label: {
                    Text("회원가입")
                    Image(systemName: "chevron.right")
                }
                .foregroundColor(.gray)
                .navigationTitle("로그인")
                Spacer()
            }
            .padding()
            
            Spacer()
        }
        
    }
}

struct SettingLoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingLoginView()
                .environmentObject(Router())
        }
    }
}
