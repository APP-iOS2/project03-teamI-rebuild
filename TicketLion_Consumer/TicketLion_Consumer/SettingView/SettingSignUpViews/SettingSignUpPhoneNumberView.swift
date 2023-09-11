//
//  SettingSignUpPhoneNumberView.swift
//  TicketLion_Comsumer
//
//  Created by 김윤우 on 2023/09/06.
//

import SwiftUI

//extension Color {
//    static let anyButtonColor = Color("AnyButtonColor")
//    static let mainColor = Color("MainColor")
//    static let pickerButtonColor = Color("PickerButtonColor")
//
//}


struct SettingSignUpPhoneNumberView: View {
    
    @State private var number: String = ""

    @Binding var isCompleteSignUp: Bool
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading, spacing: 25 ){
                
                Divider()
                    .background(Color("AnyButtonColor"))
                
                HStack{
                    Text("휴대폰번호").fontWeight(.bold) +
                    Text("를\n입력해주세요")
                    
                    Spacer()
                    
                    Text("4/5")
                }
                .font(.title2)
                
                TextField("- 없이 입력", text: $number)
                    .padding()
                    .background(Color(uiColor: .secondarySystemBackground))
                    .cornerRadius(5)
                
                NavigationLink {
                    
                    SettingSignUpBirthView(isCompleteSignUp: $isCompleteSignUp)
                    
                } label: {
                    
                    Text("다음")
                }
                .frame(maxWidth: .infinity, maxHeight: 20)
                .padding()
                .font(.title2)
                .foregroundColor(.white)
                .background(number.isEmpty ?  Color.gray : Color("AnyButtonColor"))
                .cornerRadius(5)
                .disabled(number.isEmpty)
                
            }
            .padding()
            .navigationTitle("회원가입")
            .navigationBarTitleDisplayMode(.inline)
            
            Spacer()
            
        }
    }
}


struct SettingSignUpPhoneNumberView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            SettingSignUpPhoneNumberView(isCompleteSignUp: .constant(false))
        }
    }
}
