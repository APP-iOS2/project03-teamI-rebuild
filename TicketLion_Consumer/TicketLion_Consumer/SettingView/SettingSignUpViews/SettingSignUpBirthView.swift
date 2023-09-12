
//
//  SettingSignUpBirthView.swift
//  TicketLion_Comsumer
//
//  Created by 김윤우 on 2023/09/06.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct SettingSignUpBirthView: View {
    
    @ObservedObject var signUpStore: SignUpStore
    
    let db = Firestore.firestore()
    
   @State private var birth: String = ""
   
   @Binding var isCompleteSignUp: Bool
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
               TextField("ex)19960422", text: $signUpStore.birth)
                   .padding()
                   .background(Color(uiColor: .secondarySystemBackground))
                   .cornerRadius(5)
               
               
               
               NavigationLink {
                   SettingSignUpCompleteView( signUpStore: signUpStore, isCompleteSignUp: $isCompleteSignUp)
                       .onAppear {
                               fetchUser()
                       }
               } label: {
                   
                   Text("다음")
               }
               .frame(maxWidth: .infinity, maxHeight: 20)
               .padding()
               .font(.title2)
               .foregroundColor(.white)
               .background(signUpStore.birth.isEmpty ?  Color.gray : Color("AnyButtonColor"))
               .cornerRadius(5)
               .disabled(signUpStore.birth.isEmpty)
               
               
           }
           .padding()
           .navigationTitle("회원가입")
           .navigationBarTitleDisplayMode(.inline)
           
           Spacer()
       }
   }
    
    func fetchUser() {
        let user =  User(name: signUpStore.name,
                         phoneNumber: signUpStore.phoneNumber,
                         email: signUpStore.email,
                         password: signUpStore.password,
                         birth: signUpStore.birth,
                         appliedSeminars: [],
                         favoriteSeminars: [],
                         recentlySeminars: [],
                         canceledSeminars: [])
        
        print("오케이")
        
        do {
          try db.collection("User").document(user.id).setData(from: user)
        } catch {
            print(error)
        }
    }
   
}

struct SettingSignUpBirthView_Previews: PreviewProvider {
   static var previews: some View {
       NavigationStack{
           SettingSignUpBirthView(signUpStore: SignUpStore(), isCompleteSignUp: .constant(false))
       }
   }
}
