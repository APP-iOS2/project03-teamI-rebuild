//
//  MyFavoriteView.swift
//  TicketLion_Comsumer
//
//  Created by Muker on 2023/09/06.
//

import SwiftUI

struct MyFavoriteView: View {
    //아직 안써요
    @ObservedObject var mySeminarStore: MySeminarStore
    @State private var selectedSeminar = Seminar.TempSeminar
    
    @State private var isShowingDetail = false
    
    func timeCreator(_ time: Double) -> String {
        let createdAt: Date = Date(timeIntervalSince1970: time)
        let fomatter: DateFormatter = DateFormatter()
        fomatter.dateFormat = "hh:mm a"
        
        return fomatter.string(from: createdAt)
    }
    
    func dateCreator(_ time: Double) -> String {
        let createdAt: Date = Date(timeIntervalSince1970: time)
        let fomatter: DateFormatter = DateFormatter()
        fomatter.dateFormat = "yyyy년 MM월 dd일"
        
        return fomatter.string(from: createdAt)
    }
    
    
    
    var body: some View {
        
        ScrollView {
            
            ForEach(Seminar.seminarsDummy) { seminar in
                Button {
                    
                    isShowingDetail = true
                    
                } label: {
                    VStack(alignment: .leading) {
                        HStack(alignment: .top) {
                            Text("\(seminar.name)") // 메인 타이틀
                                .foregroundColor(.black)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                            
                            Spacer()
                            
                            Button { // 즐겨찾기 버튼
                                // 헉 구조체 안에 즐겨찾기 체크하는 bool값이 필요할지도, 그런데 배열안에 들어가 있는 구조체 값도 변경 가능한가요? 갑자기 헷갈..
                                
                            } label: {
                                
                                Image(systemName:  "star.fill")
                                    .foregroundColor(Color("AnyButtonColor"))
                                    
                            }
                        }
                        .bold()
                        .font(.callout)
                        
                        VStack {
                            HStack(alignment: .top) {
                                AsyncImage(url: URL(string: seminar.seminarImage)) { image in
                                    image.resizable()
                                        .frame(width: 100, height: 100)
                                        .aspectRatio(contentMode: .fit)
                                } placeholder: {
                                    ProgressView()
                                } // 이미지
                                
                                Spacer()
                                
                                VStack(alignment: .leading) { // 세미나 디테일
                                    Group {
                                        Text("강연자 : \(seminar.host)")
                                        Text("장소 : \(seminar.location ?? "location -")")
                                        Text("날짜 : \(dateCreator(seminar.registerStartDate))")
                                        Text("시간 : \(timeCreator( seminar.registerStartDate)) ~ \(timeCreator( seminar.registerEndDate))")
                                    }
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0))
                                    .foregroundColor(.black)
                                    .font(.footnote)
                                }
                                
                                
                            }
                        }
                    } // VStack 끝
                    .padding()
                    .background(Color("Color"))
                    .cornerRadius(20)
                    .padding(EdgeInsets(top: 0, leading: 15, bottom: 15, trailing: 15))
                    
                }
            }//ForEach
            .fullScreenCover(isPresented: $isShowingDetail) {
                NavigationStack {
                    
//                    SeminarDetailView(isShowingDetail: $isShowingDetail, seminar: $seminar)
                }
            }
            
        } //ScrollView
        
    }
}

struct MyFavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        MyFavoriteView(mySeminarStore: MySeminarStore())
    }
}
