//
//  SeminarDetailView.swift
//  TicketLion_Comsumer
//
//  Created by 남현정 on 2023/09/06.
//

import SwiftUI

struct SeminarDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userStore: UserStore
    @Binding var isShowingDetail: Bool
    @State var isShowingAlert: Bool = false
    @Binding var seminar: Seminar
    
    ///하단 신청 버튼 ( 원래.contains("\(dummy.id)") )
    private var attendButtonText: String {
        if let _ = userStore.currentUser, userStore.appliedSeminars.contains("\(seminar.id)"){ //로그인되어있고, 신청되었다면
            return "이미 신청한 세미나입니다"
        }else if seminar.closingStatus{ //모집마감이면
            return "모집이 마감되었습니다"
        }
        return "신청하기"
    }
    private var attendButtonColor: Color {
        if let _ = userStore.currentUser, userStore.appliedSeminars.contains("\(seminar.id)"){ //로그인되어있고, 신청되었다면
            return .gray
        }else if seminar.closingStatus{ //모집마감이면
            return .gray
        }
        
        return Color("AnyButtonColor")
        
    }
    private var attendButtonDisabled: Bool {
        if let _ = userStore.currentUser { //로그인상태
            if !userStore.appliedSeminars.contains("\(seminar.id)") && !seminar.closingStatus{ //신청안되어있고 모집중일때만 활성화
                return false
            }
            return true //나머지는 비활성화
        }
        //로그인안되어있으면
        if !seminar.closingStatus {
            return false
        }
        return true
        
    }
    
    ///모집중, 모집마감
    private var recruiteText: String {
        seminar.closingStatus ? "모집마감" : "모집중"
    }
    private var recruiteColor: Color {
        seminar.closingStatus ? .red : .blue
    }
    
    var body: some View {
        VStack {
            ScrollView {
                
                VStack {
                    ZStack {
                        
                        AsyncImage(url: URL(string: seminar.seminarImage)) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: 270)
                            } else if phase.error != nil {
                                Image("TicketLion")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: 270)
                                
                            } else {
                                Image("TicketLion")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: 270)
                            }
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))
                        
                        
                        
                        //모집마감 여부 눈에 띄면 좋을 것 같아서 추가
                        Text(" \(recruiteText) ")
                            .foregroundColor(recruiteColor)
                            .border(recruiteColor)
                            .background(.white)
                            .frame(
                                maxWidth: 270,
                                maxHeight: .infinity,
                                alignment: .topLeading)
                        
                        
                    }
                    
                    Divider()
                    
                    VStack(alignment: .leading) {
                        Text("세미나")
                            .font(.title3)
                            .bold()
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
                        
                        HStack {
                            SeminarInfoView(seminar: seminar)
                            Spacer()
                        }
                    }
                    .padding()
                    
                    
                }
                
                Divider()
                
                //MARK: 행사소개
                VStack(alignment: .leading) {
                    Text("상세 소개")
                        .font(.title3)
                        .bold()
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
                    
                    Grid(alignment: .topLeading) {
                        GridRow {
                            
                            Text("상세 정보")
                                .modifier(textStyle())
                            
                            
                            Text("\(seminar.details)")
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
                        
                        GridRow {
                            Text("모집 인원")
                                .modifier(textStyle())
                            
                            Text("\(seminar.maximumUserNumber)")
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
                        
                        GridRow {
                            Text("모집 기간")
                                .modifier(textStyle())
                            
                            
                            Text("\(seminar.startDateCreator(seminar.registerStartDate)) ~ \(seminar.endDateCreator(seminar.registerEndDate, seminar.registerStartDate))")
                            
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
                        
                        GridRow {
                            Text("진행 날짜")
                                .modifier(textStyle())
                            
                            Text("\(seminar.startDateCreator(seminar.seminarStartDate)) ~ \(seminar.endDateCreator(seminar.seminarEndDate, seminar.seminarStartDate))")
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
                        
                        GridRow {
                            Text("진행 시간")
                                .modifier(textStyle())
                            
                            Text("\(seminar.timeCreator(seminar.seminarStartDate)) ~ \(seminar.timeCreator(seminar.seminarEndDate))")
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
                        
                        GridRow {
                            Text("장소")
                                .modifier(textStyle())
                            
                            if let _ = seminar.location { //오프라인이면
                                
                                Text("\(seminar.location ?? "location -")")
                                
                                
                            }else {
                                
                                Text("(온라인 진행)")
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                                
                            }
                        }
                    }
                    if let _ = seminar.location {
                        
                        SeminarDetailMapView(seminar: seminar)
                        
                    }
                    
                }
                .padding()
                
                Spacer()
                
                
            }
            
            //MARK: 신청버튼
            if let _ = userStore.currentUser {
                NavigationLink {
                    SeminarAttendView(seminar: $seminar, user: User.usersDummy[0], isShowingDetail: $isShowingDetail)
                } label: {

                        Text(attendButtonText)
                        //                    .frame(maxWidth: .infinity)
                            .font(.title2.bold())
                            .frame(width: 380,height: 60) //버튼 전체 눌리도록
                    

                }
                .foregroundColor(.white)
                .background(attendButtonColor)
                .cornerRadius(5)
                .disabled(attendButtonDisabled)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))

            }else {
            
                
                Button {
                    isShowingAlert = true
                    
                } label: {
                    Text(attendButtonText)
                        .font(.title2.bold())
                        .frame(width: 380,height: 60) //버튼 전체 눌리도록
                }
                .foregroundColor(.white)
                .background(attendButtonColor)
                .cornerRadius(5)
                .disabled(attendButtonDisabled)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))

            }

            
        }
        .navigationTitle(seminar.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    //                    isShowingDetail = false
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.orange)
                }
                
            }
        }
        .alert(isPresented: $isShowingAlert) {
            Alert(title: Text("로그인후 이용해주세요"),
                  message: nil,
                  primaryButton: .default(Text("OK")) {
                
                isShowingDetail = false
                userStore.loginSheet = true
                print("\(userStore.loginSheet)")
            },
                  secondaryButton: .cancel()
            )
        }
    }
    
}


struct SeminarDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SeminarDetailView(isShowingDetail: .constant(true), seminar: .constant(Seminar.seminarsDummy[1]))
                .environmentObject(UserStore())
            
        }
    }
}
