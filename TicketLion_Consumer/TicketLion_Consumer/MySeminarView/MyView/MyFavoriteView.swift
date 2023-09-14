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
    @EnvironmentObject var userStore: UserStore
    @State private var selectedSeminar = Seminar.TempSeminar
    @State private var isShowingDetail = false
    
    
    var body: some View {
        
        ScrollView {
            
            ForEach(mySeminarStore.seminarList.filter {
                userStore.favoriteSeminars.contains($0.id)
            }) { seminar in
                Button {
                    
                    isShowingDetail = true
                    selectedSeminar = seminar
                    
                } label: {
                    VStack(alignment: .leading) {
                        HStack(alignment: .top) {
                            Text("\(seminar.name)") // 메인 타이틀
                                .foregroundColor(.black)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                            
                            Spacer()
                            
                            Button { // 즐겨찾기 버튼
                                
                                
                                if userStore.favoriteSeminars.firstIndex(of: "\(seminar.id)") != nil {
                                    // 즐겨찾기 없애기
                                    userStore.removeFavoriteSeminar(seminarID: seminar.id)
                                    print("\(userStore.favoriteSeminars)")
                                } else {
                                    // 즐겨찾기 넣기
                                    userStore.addFavoriteSeminar(seminarID: seminar.id)
                                    print("\(userStore.favoriteSeminars)")
                                }
                            } label: {
                                
                                Image(systemName: userStore.favoriteSeminars.contains(seminar.id) ? "star.fill" : "star")
                                    .foregroundColor(userStore.favoriteSeminars.contains(seminar.id) ? Color("AnyButtonColor") : .gray)
                            }
                        }
                        .bold()
                        .font(.callout)
                        
                        VStack {
                            //이미지 변경 해야함
                            HStack(alignment: .top) {
								
								AsyncImage(url: URL(string: seminar.seminarImage)) { phase in // 이미지
									if let image = phase.image {
										image
										.resizable()
										.frame(width: 100, height: 100)
										.aspectRatio(contentMode: .fill)
									} else if phase.error != nil { // 에러 있을때
										Image("TicketLion")
											.resizable()
											.frame(width: 100, height: 100)
											.aspectRatio(contentMode: .fill)
									} else { // placeholder
										Image("TicketLion")
											.resizable()
											.frame(width: 100, height: 100)
											.aspectRatio(contentMode: .fill)
									}
								}
                                
                                Spacer()
                                
                                VStack(alignment: .leading) { // 세미나 디테일
                                    Group {
                                        Text("강연자 : \(seminar.host)")
                                        Text("장소 : \(seminar.location ?? "location -")")
                                        Text("날짜 : \(mySeminarStore.dateCreator(seminar.registerStartDate))")
                                        Text("시간 : \(mySeminarStore.timeCreator( seminar.registerStartDate)) ~ \(mySeminarStore.timeCreator( seminar.registerEndDate))")
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
                    
                    SeminarDetailView(isShowingDetail: $isShowingDetail, seminar: $selectedSeminar)
                }
            }
            
        } //ScrollView
        
    }
}

struct MyFavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        MyFavoriteView(mySeminarStore: MySeminarStore()).environmentObject(UserStore())
    }
}
