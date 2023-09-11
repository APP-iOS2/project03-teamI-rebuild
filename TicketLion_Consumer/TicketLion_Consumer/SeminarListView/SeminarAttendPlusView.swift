//
//  SeminarAttendPlusView.swift
//  TicketLion_Comsumer
//
//  Created by 윤진영 on 2023/09/09.
//

import SwiftUI

struct SeminarAttendPlusView: View {

    @State private var alertText: String = "세미나 신청이 완료되었습니다."
    @State private var selectedOption: Int?
    @State private var selectedOption2: Int?
    private var isButton: Bool {
        if (selectedOption == nil) || (selectedOption2 == nil) {
            return false
        } else {
            return true
        }
    }
    @State private var isShowingAlert : Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var isShowingDetail: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
        Group {
            Text("- 이전 세미나 모집 참여 여부?")
                .font(.headline).padding(5)
            HStack {
                    Button {
                        selectedOption = 1
                    } label: {
                        Image(systemName: selectedOption == 1 ? "checkmark.circle.fill" : "checkmark.circle")
                            .font(.system(size: 30))
                            .foregroundColor(Color("MainColor"))
                        Text("있다")
                            .foregroundColor(.primary)
                    }
                    
                    Spacer()
                Button {
                        selectedOption = 2
                    } label: {
                        Image(systemName: selectedOption == 2 ? "checkmark.circle.fill" : "checkmark.circle")
                            .font(.system(size: 30))
                            .foregroundColor(Color("MainColor"))
                        Text("없다")
                            .foregroundColor(.primary)
                    }
                    
                Spacer()
            }
            Text("- 흥미있는 개발직군?")
                .font(.headline).padding(5)
            HStack {
                    Button {
                        selectedOption2 = 1
                    } label: {
                        Image(systemName: selectedOption2 == 1 ? "checkmark.circle.fill" : "checkmark.circle")
                            .font(.system(size: 30))
                            .foregroundColor(Color("MainColor"))
                        Text("앱개발")
                            .foregroundColor(.primary)
                    }
                    
                Spacer()
                    Button {
                        selectedOption2 = 2
                    } label: {
                        Image(systemName: selectedOption2 == 2 ? "checkmark.circle.fill" : "checkmark.circle")
                            .font(.system(size: 30))
                            .foregroundColor(Color("MainColor"))
                        Text("웹개발")
                            .foregroundColor(.primary)
                    }
                    
                Spacer()
            }
        }.padding(.leading,10)
                
            VStack {
                Spacer()
                Button {
                    if (selectedOption == nil) || (selectedOption2 == nil) {
                        isShowingAlert = true
                        alertText = "모두 체크해 주세요"
                    }else {
                        isShowingAlert = true
                        alertText = "세미나 신청이 완료되었습니다."
                    }
                } label: {
                    Text("제출하기")
                        .font(.title2.bold())
                        .frame(width:380,height: 70)
                        .background(isButton ? Color("AnyButtonColor") : Color(.gray))
                        .cornerRadius(5)
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                }.padding(.top,10)
                
                Spacer()
                    .alert(isPresented: $isShowingAlert){
                        Alert(title: Text(alertText),
                              dismissButton: .default(Text("확인")){
                            if (selectedOption != nil) && (selectedOption2 != nil){
                                isShowingDetail = false
                            }
                            //presentationMode.wrappedValue.dismiss()
                        })
                    }
            }
        }
    }
}

struct SeminarAttendPlusView_Previews: PreviewProvider {
    static var previews: some View {
        SeminarAttendPlusView(isShowingDetail: .constant(true))
    }
}
