//
//  MyReservationView.swift
//  TicketLion_Comsumer
//
//  Created by Muker on 2023/09/06.
//

import SwiftUI
import SimpleToast

struct MyReservationView: View {
    
    @ObservedObject var mySeminarStore: MySeminarStore
    
    @State private var selectedCategory: MyCategoryButton = .whole
    @State private var isShowingSheet = false
    @State private var starChecker = false
    @State private var showingToast = false
    @State private var selectedSeminar = Seminar.TempSeminar
    
    let toastOptions = SimpleToastOptions(
        alignment: .bottom,
        hideAfter: 2,
        animation: .easeInOut,
        modifierType: .slide
    )
    
    var body: some View {
        VStack {
            myCategoryButton
                .padding(.top, 3)
            
            ScrollView {
                ForEach(mySeminarStore.seminarList, id: \.id) { seminar in
                    
                    Button {
                        isShowingSheet = true
                        mySeminarStore.selectedSeminar = seminar
                    } label: {
                        VStack(alignment: .leading) {
                            HStack(alignment: .top) {
                                Text("\(seminar.name)") // 메인 타이틀
                                    .foregroundColor(.black)
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                                
                                Spacer()
                                
                                Button { // 즐겨찾기 버튼
                                    // 헉 구조체 안에 즐겨찾기 체크하는 bool값이 필요할지도, 그런데 배열안에 들어가 있는 구조체 값도 변경 가능한가요? 갑자기 헷갈..
                                    starChecker.toggle()
                                } label: {
                                    
                                    Image(systemName: starChecker ? "star.fill" : "star")
                                        .foregroundColor(starChecker ? Color("AnyButtonColor") : .gray) // 이 부분은 삼항연산자로 색 바꿔야합니다.
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
                                            Text("날짜 : \(seminar.registerStartDate)")
                                            Text("시간 : \(timeCreator(time: seminar.registerStartDate)) ~ \(timeCreator(time: seminar.registerEndDate))")
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
                    .sheet(isPresented: $isShowingSheet) {
                        MyTicketSheetView(mySeminarStore: mySeminarStore,
                                          showingToast: $showingToast,
                                          isShowingSheet: $isShowingSheet
                        )
                            .presentationDetents([.height(570)])
                            .presentationDragIndicator(.visible)
                    }
                    
                }
                
            }
            .simpleToast(isPresented: $showingToast, options: toastOptions) {
                HStack {
                       Image(systemName: "exclamationmark.triangle")
                       Text("해당 세미나의 티켓 예매가 취소 되었습니다.")
                   }
                   .padding(15)
                   .background(Color.brown.opacity(0.8))
                   .foregroundColor(Color.white)
                   .cornerRadius(14)
               }
        }
    }
}


extension MyReservationView {
    var myCategoryButton: some View {
        HStack {
            ForEach(MyCategoryButton.allCases, id: \.rawValue) { category in
                VStack {
                    if category == selectedCategory {
                        Text(category.title)
                            .font(.body)
                            .foregroundColor(.white)
                            .padding(.vertical, 4)
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                            .background(Color("AnyButtonColor"))
                            .cornerRadius(20)
                            
                    } else {
                        Text(category.title)
                            .padding(.vertical, 4)
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray, lineWidth: 1.5)
                            )
                        
                    }
                }
                .onTapGesture {
                    withAnimation(Animation.default) {
                        self.selectedCategory = category
                        print(self.selectedCategory)
                    }
                }
            }
            .padding(.leading, 2)
            Spacer()
        }
        .padding(.leading)
    }
}

struct MyReservationView_Previews: PreviewProvider {
    static var previews: some View {
        MyReservationView(mySeminarStore: MySeminarStore())
    }
}
