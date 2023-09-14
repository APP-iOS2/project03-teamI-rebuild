
//
//  SettingSignUpBirthView.swift
//  TicketLion_Comsumer
//
//  Created by 김윤우 on 2023/09/06.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

struct SettingSignUpBirthView: View {
    
    @ObservedObject var userStore: UserStore
    
    @State private var birth: String = ""
    
//    @Binding var isCompleteSignUp: Bool
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading, spacing: 25 ){
                
                Divider()
                    .background(Color("AnyButtonColor"))
                
                HStack{
                    Text("") +
                    Text("생년월일").fontWeight(.bold) +
                    Text("을\n입력해주세요")
                    
                    Spacer()
                    Text("5/5")
                }
                .font(.title2)
                TextField("ex)19960422", text: $userStore.birth)
                    .keyboardType(.decimalPad)
                    .padding()
                    .background(Color(uiColor: .secondarySystemBackground))
                    .cornerRadius(5)
                    .keyboardType(.decimalPad)
                
                
                NavigationLink {
                    SettingSignUpCompleteView(/* isCompleteSignUp: $isCompleteSignUp */)
                        .onAppear {
							Task {
                                await userStore.signUpUser(name: userStore.name, email: userStore.email, password: userStore.password, phoneNumber: userStore.phoneNumber, birth: userStore.birth)
							}
                            
                        }
                } label: {
                    
                    Text("다음")
                        .frame(maxWidth: .infinity, maxHeight: 20)
                        .padding()
                        .font(.title2)
                        .foregroundColor(.white)
                        .background(userStore.birth.isEmpty ?  Color.gray : Color("AnyButtonColor"))
                        .cornerRadius(5)
                }
                .disabled(userStore.birth.isEmpty)
                
                
            }
            .padding()
            .navigationTitle("회원가입")
            .navigationBarTitleDisplayMode(.inline)
            
            Spacer()
        }
    }
}

struct SettingSignUpBirthView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            SettingSignUpBirthView(userStore: UserStore() /*, isCompleteSignUp: .constant(false) */)
        }
    }
}
