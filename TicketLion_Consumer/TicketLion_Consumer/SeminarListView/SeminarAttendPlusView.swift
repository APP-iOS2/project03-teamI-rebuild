//
//  SeminarAttendPlusView.swift
//  TicketLion_Comsumer
//
//  Created by 윤진영 on 2023/09/09.
//

import SwiftUI

struct SeminarAttendPlusView: View {
    @EnvironmentObject var userStore: UserStore
    @StateObject var seminarStore: SeminarStore = SeminarStore() // 세미나에 유저 저장하기 위해
    @State var research : Research = Research(seminarID: "", userID: "")
    @State private var alertText: String = "세미나 신청이 완료되었습니다."
    @State private var isShowingAlert : Bool = false
    @Binding var seminar: Seminar
    
    private var isButton: Bool {
        if research.answer1 == nil || research.answer2 == nil {
            return false
        } else {
            return true
        }
    }
    @Binding var isShowingDetail: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text("- 이전 세미나 모집 참여 여부?")
                    .bold()
                    .foregroundColor(.primary)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
                HStack {
                    Button {
                        research.answer1 = 1
                    } label: {
                        Image(systemName: research.answer1 == 1 ? "checkmark.circle.fill" : "checkmark.circle")
                            .font(.system(size: 30))
                            .foregroundColor(Color("MainColor"))
                        Text("있다")
                            .foregroundColor(.primary)
                    }
                    
                    Spacer()
                    Button {
                        research.answer1 = 2
                    } label: {
                        Image(systemName: research.answer1 == 2 ? "checkmark.circle.fill" : "checkmark.circle")
                            .font(.system(size: 30))
                            .foregroundColor(Color("MainColor"))
                        Text("없다")
                            .foregroundColor(.primary)
                    }
                    
                    Spacer()
                }
            }.padding(EdgeInsets(top: 0, leading: 10, bottom: 8, trailing: 0))
            Group {
                Text("- 흥미있는 개발직군?")
                    .bold()
                    .foregroundColor(.primary)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
                HStack {
                    Button {
                        research.answer2 = 1
                    } label: {
                        Image(systemName: research.answer2 == 1 ? "checkmark.circle.fill" : "checkmark.circle")
                            .font(.system(size: 30))
                            .foregroundColor(Color("MainColor"))
                        Text("앱개발")
                            .foregroundColor(.primary)
                    }
                    
                    Spacer()
                    Button {
                        research.answer2 = 2
                    } label: {
                        Image(systemName: research.answer2 == 2 ? "checkmark.circle.fill" : "checkmark.circle")
                            .font(.system(size: 30))
                            .foregroundColor(Color("MainColor"))
                        Text("웹개발")
                            .foregroundColor(.primary)
                    }
                    Spacer()
                }
            } .padding(EdgeInsets(top: 0, leading: 10, bottom: 8, trailing: 0))
            
            VStack {
                Spacer()
                Button {
                    if research.answer1 == nil || research.answer2 == nil {
                        isShowingAlert = true
                        alertText = "모두 체크해 주세요"
                    }else if (research.answer1 != nil) && (research.answer2 != nil){
                        isShowingAlert = true
                        // 세미나신청 함수
                        userStore.addSeminar(seminarID: seminar.id)
                        seminarStore.addUserPhoneNumberInSeminar(seminar: seminar, userEmail: userStore.email)
                        alertText = "세미나 신청이 완료되었습니다."
                    }
                } label: {
                    Text("제출하기")
                        .font(.title2.bold())
                        .frame(width:380,height: 60)
                        .background(isButton ? Color("AnyButtonColor") : Color(.gray))
                        .cornerRadius(5)
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                }.padding(.top,10)
                
                Spacer()
                    .alert(isPresented: $isShowingAlert){
                        Alert(title: Text(alertText),
                              dismissButton: .default(Text("확인")){
                            if (research.answer1 != nil) && (research.answer2 != nil){
                                isShowingDetail = false
                            }
                        })
                    }
            }
        }
    }
}

struct SeminarAttendPlusView_Previews: PreviewProvider {
    static var previews: some View {
        SeminarAttendPlusView(seminar: .constant(Seminar.TempSeminar), isShowingDetail: .constant(true))
    }
}
