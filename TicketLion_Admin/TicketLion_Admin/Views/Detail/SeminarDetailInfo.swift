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
                        Text("소개 글")
                            .font(.system(size: 30) .bold())
                            .padding(.bottom, 7)
                        
                        Text(seminars.details)
                        Divider()
                            .padding(.top, 12)
                        
                        Text("일시")
                            .font(.system(size: 30) .bold())
                            .padding(.bottom, 7)
                        
                        Text(seminars.seminarDate)
                        Divider()
                            .padding(.top, 12)
                        Text("장소")
                            .font(.system(size: 30) .bold())
                            .padding(.bottom, 7)
                        
                        Text(seminars.location ?? "장소가 있어야 함")
                        Divider()
                            .padding(.top, 7)
                    } // VStack
                    Text("대표이미지")
                        .font(.system(size: 30) .bold())

                    if let userImage = seminars.seminarImage {
                        AsyncImage(url: URL(string: userImage)) { image in
                            image
                                .resizable()
                                .clipShape(Circle())
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 400)
                        } placeholder: {
                            ProgressView()
                        }
                    } else {
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 150))
                    }
                }
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
