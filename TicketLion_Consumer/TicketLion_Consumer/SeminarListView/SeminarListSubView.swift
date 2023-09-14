//
//  SeminarListSubView.swift
//  TicketLion_Consumer
//
//  Created by 이재승 on 2023/09/13.
//

import SwiftUI

struct SeminarListSubView: View {
    @ObservedObject var seminarStore: SeminarStore
    @EnvironmentObject var userStore: UserStore
    @Binding var category: Category
    @Binding var search: String
    
    @State var isShowingDetail: Bool = false
    @Binding var showingAlert: Bool
    
    @State var newSeminar: Seminar = Seminar.seminarsDummy[1] // 디테일뷰로 전달할때 쓸 seminar 구조체입니다. dummy는 변경할거라 임시로 넣은 것.
    
    var body: some View { // 등록시작순으로 정렬했습니다. 서치바를 사용해서 검색되게끔 구현했습니다.
        ForEach(seminarStore.seminarList.sorted(by: {$0.registerStartDate < $1.registerStartDate}).filter({"\($0)".localizedStandardContains(self.search) || self.search.isEmpty})) { seminar in
            
            if seminar.category.contains(category.categoryName) {
                
                Button {
                    newSeminar = seminar // 이부분에서 seminar 데이터를 바운딩으로 넘겨주기 위해 초기화합니다.
                    isShowingDetail = true // 디테일시트로 넘어갑니다.
                } label: {
                    VStack(alignment: .leading) {
                        
                        HStack(alignment: .top) { // 상단 제목 부분입니다.
                            
                            Text("\(seminar.name)") // 메인 타이틀
                                .foregroundColor(.black)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                            
                            Spacer()
                            
                            Text("\(seminar.enterUsers.count)/\(seminar.maximumUserNumber)")
                                .padding(EdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 2))
                                .background(Color("AnyButtonColor"))
                                .foregroundColor(.white)
                                .cornerRadius(3)
                            
                            
                            Text(seminar.closingStatus ? "모집마감" : "모집중")
                                .padding(EdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 2))
                                .background(seminar.closingStatus ? .red : .blue)
                                .border(seminar.closingStatus ? .red : .blue)
                                .foregroundColor(.white)
                                .cornerRadius(3)
                            
                            
                            
                            
                            Button { // 즐겨찾기 버튼
                                // User, favoriteSeminar에 저장
                                // 저장 후 User의 favoriteSeminar 배열에 해당 Seminar가 있으면 즐겨찾기 버튼에 불이 들어와야한다.
                                if let _ = userStore.currentUser {
                                    if userStore.favoriteSeminars.firstIndex(of: "\(seminar.id)") != nil {
                                        // 즐겨찾기 없애기
                                        userStore.removeFavoriteSeminar(seminarID: seminar.id)
                                        print("\(userStore.favoriteSeminars)")
                                        
                                    } else {
                                        // 즐겨찾기 넣기
                                        userStore.addFavoriteSeminar(seminarID: seminar.id)
                                        print("\(userStore.favoriteSeminars)")
                                        
                                    }
                                } else {
                                    showingAlert = true
                                }
                            } label: {
                                
                                Image(systemName: userStore.favoriteSeminars.contains(seminar.id) ? "star.fill" : "star")
                                    .foregroundColor(userStore.favoriteSeminars.contains(seminar.id) ? Color("AnyButtonColor") : .gray)
                            }
                        }
                        .bold()
                        .font(.callout)
                        
                        VStack {
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
                                
                                
                                VStack(alignment: .leading) { // 세미나 디테일 내용입니다.
                                    Group {
                                        Text("강연자 : \(seminar.host)")
                                        Text("장소 : \(seminar.location ?? "location -")")
                                        Text("날짜 : \(seminar.startDateCreator(seminar.registerStartDate)) 부터")
                                        Text("시간 : \(seminar.timeCreator( seminar.registerStartDate)) ~ \(seminar.timeCreator( seminar.registerEndDate))")
                                    }
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0))
                                    
                                    .foregroundColor(.black)
                                    .font(.footnote)
                                }
                                .padding(EdgeInsets(top: 0, leading: 7, bottom: 0, trailing: 0))
                                
                            }
                        }
                    } // 전체 VStack 끝
                    .padding()
                    .background(Color("Color"))
                    .cornerRadius(20)
                    .padding(EdgeInsets(top: 0, leading: 15, bottom: 15, trailing: 15))
                    
                } // 라벨 끝
            }
        }
        .onChange(of: isShowingDetail, perform: { newValue in
            seminarStore.fetchSeminar()
        })
        .fullScreenCover(isPresented: $isShowingDetail) {
            NavigationStack {
                // 여기에 디테일 뷰
                SeminarDetailView(isShowingDetail: $isShowingDetail, seminar: $newSeminar)
            }
        }
    }
}

struct SeminarListSubView_Previews: PreviewProvider {
    static var previews: some View {
        SeminarListSubView(seminarStore: SeminarStore(), category: .constant(.iOSDevelop), search: .constant(""), showingAlert: .constant(false))
    }
}
