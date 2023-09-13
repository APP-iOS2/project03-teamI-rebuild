//
//  SeminarDetailInfo.swift
//  TicketLion_Admin
//
//  Created by 최세근 on 2023/09/06.
//

import SwiftUI

struct SeminarDetailInfo: View {
    
    let seminars: Seminar
    @ObservedObject var seminarStore: SeminarDetailStore = SeminarDetailStore()
    @Binding var seminarData: Seminar
    @State var seminarLocation: SeminarLocation
    @State var isShowEditView: Bool = false
    
    var deadline: String {
        seminarStore.recruitingList.contains(where: { $0.id == seminars.id }) ? "진행중" : "마감"
    }
    
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .center) {
                    Form {
                        Section {
                            
                            Text("소개글")
                                .font(.system(size: 20) .bold())
                                .padding(.bottom, 7)
                            Text(seminars.details)
                                .padding(.top, 12)
                        }
                        Section {
                            Text("주최자")
                                .font(.system(size: 20) .bold())
                            
                            
                            Text(seminars.host)
                        }
                        Section {
                            Text("장소")
                                .font(.system(size: 20) .bold())
                            
                            
                            Text(seminars.location ?? "장소가 있어야 함")
                        }
                        
                        Section {
                            Text("모집인원")
                                .font(.system(size: 20) .bold())
                            
                            // Date 형식으로 바꿔야함
                            Text(("\(seminars.enterUsers.count)/\(seminars.maximumUserNumber)"))
                        }
                        Section {
                            Text("마감날짜")
                                .font(.system(size: 20) .bold())
                            
                            
                            Text(seminars.registerEndDate.description.detailcalculateDate(date: seminars.registerEndDate))
                        }
                        Section {
                            Text("마감여부")
                                .font(.system(size: 20) .bold())
                            Text(deadline)
                        }
                        // VStack
                        Section {
                            Text("대표이미지")
                                .font(.system(size: 20) .bold())
                            
                            //                                if let userImage = seminars.seminarImage {
                            //                                    AsyncImage(url: URL(string: userImage)) { image in
                            //                                        image
                            //                                            .resizable()
                            //                                            .clipShape(Circle())
                            //                                            .aspectRatio(contentMode: .fit)
                            //                                            .frame(width: 400)
                            //                                    } placeholder: {
                            //                                        ProgressView()
                            //                                    }
                            //                                } else {
                            //                                    Image(systemName: "person.circle.fill")
                            //                                        .font(.system(size: 150))
                            //                                }
                        }
                    }
                }
            } // NavigationStack 다음 VStack
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        NavigationLink(destination: SeminarDetailEditView(chipsViewModel: ChipsViewModel(), seminars: seminars, seminarLocation: seminarLocation, seminarData: $seminarData, isShowEditView: $isShowEditView), label: {
                            Text("수정")
                        })
                    } label: {
                        Image(systemName: "ellipsis")
                            .foregroundColor(.black)
                    }
                }
            }
            .navigationTitle(seminars.name)
            .onAppear {
                seminarStore.fetchSeminar { success in
                    if success {
                        print("패치 성공")
                    } else {
                        print("패치 실패")
                    }
                }
            }
            .refreshable {
                seminarStore.fetchSeminar { success in
                    if success {
                        print("패치 성공")
                    } else {
                        print("패치 실패")
                    }
                }
            }
        } // NavigationStack
    }
}

struct SeminarDetailInfo_Previews: PreviewProvider {
    static var previews: some View {
        SeminarDetailInfo(seminars: Seminar.seminarsDummy[0], seminarData: .constant(Seminar.seminarsDummy[0]), seminarLocation: SeminarLocation(latitude: 37.5665, longitude: 126.9780, address: "서울시청"))
    }
}
