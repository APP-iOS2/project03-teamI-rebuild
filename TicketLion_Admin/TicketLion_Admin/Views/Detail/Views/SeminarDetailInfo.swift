//
//  SeminarDetailInfo.swift
//  TicketLion_Admin
//
//  Created by 최세근 on 2023/09/06.
//

import SwiftUI

struct SeminarDetailInfo: View {
    
    let seminars: Seminar
    @Binding var seminarData: Seminar
    @State var seminarLocation: SeminarLocation

    @State var isShowEditView: Bool = false
    
    var body: some View {
            NavigationStack {
                VStack {
                    VStack(alignment: .center) {
                        Form {
                            Section {
                                
                                Text("소개 글")
                                    .font(.system(size: 20) .bold())
                                    .padding(.bottom, 7)
                                Text(seminars.details)
                                    .padding(.top, 12)
                            }
                            Section {
                                Text("일시")
                                    .font(.system(size: 20) .bold())
                                
                                // Date 형식으로 바꿔야함 
                                Text("\(seminars.registerStartDate)")
                            }

                            Section {
                                Text("장소")
                                    .font(.system(size: 20) .bold())
  
                                
                                Text(seminars.location ?? "장소가 있어야 함")
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
                            NavigationLink(destination: SeminarDetailEditView(seminars: seminars, seminarLocation: seminarLocation, seminarData: $seminarData, isShowEditView: $isShowEditView), label: {
                                Text("수정")
                            })
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundColor(.black)
                        }
                    }
                }
                .navigationTitle("해당된 세미나")
            } // NavigationStack
    }
}

struct SeminarDetailInfo_Previews: PreviewProvider {
    static var previews: some View {
        SeminarDetailInfo(seminars: Seminar.seminarsDummy[0], seminarData: .constant(Seminar.seminarsDummy[0]), seminarLocation: SeminarLocation(latitude: 37.5665, longitude: 126.9780, address: "서울시청"))
    }
}
