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
    @State private var category: Category = .iOSDevelop
    @State private var search: String = ""
    @State var isShowingDetail: Bool = false
    
    @State var newSeminar: Seminar = Seminar.seminarsDummy[1]
    
    @State var user: User = User(name: "파이링", phoneNumber: "01011111111", email: "fighring@naver.com", password: "1111", birth: "0128", appliedSeminars: [], favoriteSeminars: ["\(Seminar.seminarsDummy[0].id)", "\(Seminar.seminarsDummy[2].id)"], recentlySeminars: [], canceledSeminars: [])
    
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
        NavigationStack {
            ScrollView {
                Picker("Category", selection: $category) {
                    Text(Category.iOSDevelop.categoryName).tag(Category.iOSDevelop)
                    Text(Category.AndroidDevelop.categoryName).tag(Category.AndroidDevelop)
                    Text(Category.FrontEnd.categoryName).tag(Category.FrontEnd)
                    Text(Category.BackEnd.categoryName).tag(Category.BackEnd)
                }
                .pickerStyle(.segmented)
                .padding()
                
                ForEach(seminarStore.seminarList.filter({"\($0)".localizedStandardContains(self.search) || self.search.isEmpty})) { seminar in
                    
                    if seminar.category.contains(category.categoryName) {
                        
                        Button {
                            newSeminar = seminar
                            isShowingDetail = true
                            print("디테일뷰에 들어갈 \n \(seminar)")
                        } label: {
                            VStack(alignment: .leading) {
                                HStack(alignment: .top) {
                                    Text("\(seminar.name)") // 메인 타이틀
                                        .foregroundColor(.black)
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                                    
                                    Spacer()
                                    
                                    Button { // 즐겨찾기 버튼
                                        // User, favoriteSeminar에 저장
                                        // 저장 후 User의 favoriteSeminar 배열에 해당 Seminar가 있으면 즐겨찾기 버튼에 불이 들어와야한다.
                                        
                                        if let firstIndex = user.favoriteSeminars.firstIndex(of: "\(seminar.id)") {
                                            user.favoriteSeminars.remove(at: firstIndex)
                                        } else {
                                            user.favoriteSeminars.append(seminar.id)
                                        }
                                    } label: {
                                        
                                        Image(systemName: user.favoriteSeminars.contains(seminar.id) ? "star.fill" : "star")
                                            .foregroundColor(user.favoriteSeminars.contains(seminar.id) ? Color("AnyButtonColor") : .gray)
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
                                                Text("날짜 : \(dateCreator(seminar.registerStartDate)) 부터")
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
                            
                        } // 라벨 끝
                    }
                } // ForEach 끝
            }
            .fullScreenCover(isPresented: $isShowingDetail) {
                NavigationStack {
                    // 여기에 디테일 뷰
                    SeminarDetailView(isShowingDetail: $isShowingDetail, seminar: $newSeminar)
                }
            }
            .onAppear {
                seminarStore.fetchSeminar()
            }
            .refreshable {
                seminarStore.fetchSeminar()
            }
            .searchable(text: $search, placement: .navigationBarDrawer(displayMode: .always), prompt: "\(category.categoryName) 세미나를 찾아보세요.")
            
        }
        .navigationTitle("Seminar")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SeminarListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SeminarListView()
        }
    }
}
