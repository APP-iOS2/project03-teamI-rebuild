
//
//  SettingSignUpBirthView.swift
//  TicketLion_Comsumer
//
//  Created by 김윤우 on 2023/09/06.
//

import SwiftUI

struct SettingSignUpBirthView: View {
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
                   TextField("ex)19960422", text: $birth)
                   .padding()
                   .background(Color(uiColor: .secondarySystemBackground))
                   .cornerRadius(5)
               
               
               
               NavigationLink {
                   SettingSignUpCompleteView( isCompleteSignUp: $isCompleteSignUp)
               } label: {
                   
                   Text("다음")
               }
               .frame(maxWidth: .infinity, maxHeight: 20)
               .padding()
               .font(.title2)
               .foregroundColor(.white)
               .background(birth.isEmpty ?  Color.gray : Color("AnyButtonColor"))
               .cornerRadius(5)
               .disabled(birth.isEmpty)
               
               
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
           SettingSignUpBirthView(isCompleteSignUp: .constant(false))
       }
   }
}
