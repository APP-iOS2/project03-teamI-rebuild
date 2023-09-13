//
//  SeminarListView.swift
//  TicketLion_Comsumer
//
//  Created by 이재승 on 2023/09/06.
//
// Q. VStack 안에 List를 사용할 경우, 탭바가 뚫리는 이유?

import SwiftUI

struct SeminarListView: View {
    
    @StateObject var seminarStore: SeminarStore = SeminarStore()
    @EnvironmentObject var userStore: UserStore
    @State private var category: Category = .iOSDevelop
    @State private var search: String = ""
    @State var isShowingDetail: Bool = false
    @State private var showingAlert = false
    
    @State var newSeminar: Seminar = Seminar.seminarsDummy[1]
    
    var body: some View {
        
        NavigationStack {
            
            ScrollView {
                Picker("Category", selection: $category) {
                    Text(Category.iOSDevelop.categoryName).tag(Category.iOSDevelop)
                    Text(Category.AndroidDevelop.categoryName).tag(Category.AndroidDevelop)
                    Text(Category.FrontEnd.categoryName).tag(Category.FrontEnd)
                    Text(Category.BackEnd.categoryName).tag(Category.BackEnd)
                }
                .pickerStyle(.segmented)
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                
                ForEach(seminarStore.seminarList.filter({"\($0)".localizedStandardContains(self.search) || self.search.isEmpty})) { seminar in
                    
                    if seminar.category.contains(category.categoryName) {
                        
                        Button {
                            newSeminar = seminar
                            isShowingDetail = true
                            print("디테일뷰에 들어갈 \n")
                        } label: {
                            VStack(alignment: .leading) {
                                HStack(alignment: .top) {
                                                                    
                                    Text("\(seminar.name)") // 메인 타이틀
                                        .foregroundColor(.black)
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                                    
                                    Spacer()
                                    
                                    
                                    Text("\(seminar.enterUsers.count)/\(seminar.maximumUserNumber)")
                                        .foregroundColor(Color("AnyButtonColor"))
                                        .border(Color("AnyButtonColor"))
                                        .background(.white)

                                    
                                    Text(seminar.closingStatus ? "모집마감" : "모집중")
                                        .foregroundColor(seminar.closingStatus ? .red : .blue)
                                        .border(seminar.closingStatus ? .red : .blue)
                                        .background(.white)

    
                                    
                                    
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
                                    }.alert(isPresented: $showingAlert) {
                                        Alert(title: Text("로그인후 이용해주세요"),
                                              message: nil,
                                              primaryButton: .default(Text("OK")) {
                                            userStore.loginSheet = true
                                        },
                                              secondaryButton: .cancel()
                                        )
                                        
                                    }
                                    .sheet(isPresented: $userStore.loginSheet, content: {
                                        NavigationStack {
                                            SettingLoginView()
                                        }
                                    })
                                }
                                .bold()
                                .font(.callout)
                                
                                VStack {
                                    HStack(alignment: .top) {
                                            
                                        AsyncImage(url: URL(string: seminar.seminarImage)) { phase in
                                            if let image = phase.image {
                                                image
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

                                        
                                        VStack(alignment: .leading) { // 세미나 디테일
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
                            } // VStack 끝
                            .padding()
                            .background(Color("Color"))
                            .cornerRadius(20)
                            .padding(EdgeInsets(top: 0, leading: 15, bottom: 15, trailing: 15))
                            
                        } // 라벨 끝
                    }
                } // ForEach 끝
            }
            .navigationTitle("세미나 목록")
//            .navigationBarTitleDisplayMode(.inline)
            .fullScreenCover(isPresented: $isShowingDetail) {
                NavigationStack {
                    // 여기에 디테일 뷰
                    SeminarDetailView(isShowingDetail: $isShowingDetail, seminar: $newSeminar)
                }
            }
            .onAppear {
                seminarStore.fetchSeminar()
                userStore.fetchUserInfo()
            }
            .refreshable {
                seminarStore.fetchSeminar()
                userStore.fetchUserInfo()
            }
            .searchable(text: $search, placement: .navigationBarDrawer(displayMode: .always), prompt: "\(category.categoryName) 세미나를 찾아보세요.")
            
        }

    }
}

struct SeminarListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SeminarListView()
                .environmentObject(UserStore())
        }
    }
}

