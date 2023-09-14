//
//  SeminarDetailEditView.swift
//  TicketLion_Admin
//
//  Created by 최세근 on 2023/09/06.
//

import SwiftUI
import MapKit
import CoreLocation

struct SeminarDetailEditView: View {
    let seminars: Seminar
    @State private var startingPoint = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780), span: MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003))
    @State private var date : Date = Date()
    @State private var isOpenMap: Bool = false
    @State private var clickLocation: Bool = false
    
    @State var seminarLocation: SeminarLocation
    @Binding var seminarData: Seminar
    @State private var introduceText: String = ""
    @Binding var isShowEditView: Bool
    private let userlimitChar: Int = 100
    private let today = Calendar.current.startOfDay(for: Date())
    
    
    var body: some View {
        VStack {
            VStack(alignment: .center) {
                Text("소개 글")
                    .font(.system(size: 30) .bold())
                    .padding(.bottom, 7)
                
                ZStack(alignment: .topLeading) {
                    VStack {
                        TextEditor(text: $introduceText)
                            .keyboardType(.default)
                            .foregroundColor(Color.black)
                            .frame(width: 600, height: 100)
                            .lineSpacing(10)
                            .shadow(radius: 2.0)
                        
                        // 글자제한
                            .onChange(of: self.introduceText, perform: {
                                if $0.count > userlimitChar {
                                    self.introduceText = String($0.prefix(userlimitChar))
                                }
                            })
                        
                        // TextEditor누르면 키보드 내려감
                            .onTapGesture {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }
                    }
                }
                
                Divider()
                    .padding(.top, 12)
                
                Text("일시")
                    .font(.system(size: 30) .bold())
                    .padding(.bottom, 7)
                
                HStack {
                    DatePicker("모집 마감 날짜 선택", selection: $date, in: self.today..., displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .padding()
                }
                
                Divider()
                    .padding(.top, 12)
                Text("장소")
                    .font(.system(size: 30) .bold())
                    .padding(.bottom, 7)
                Button {
                    isOpenMap.toggle()
                    //                  setRegion()
                } label: {
                    Label("지역 검색", systemImage: "mappin.and.ellipse")
                }
                .sheet(isPresented: $isOpenMap) {
                    //요기서 fraction 값 바꾸면 시트 비율조정 가능
                    SeminarDetailMapView(seminarStore: SeminarDetailStore(), region: $startingPoint, clickLocation: $clickLocation, seminarLocation: $seminarLocation).presentationDetents([.fraction(0.75)])
                    
                    //                Text(seminars.location ?? "장소가 있어야 함")
                    Divider()
                        .padding(.top, 7)
                } // VStack
                
                Text("대표 이미지")
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
            
            //        func setRegion() {
            //          startingPoint.center.latitude = seminars.location.latitude
            //          startingPoint.center.longitude = seminars.location.longitude
            //        }
            
        }
    }
}

struct SeminarDetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        SeminarDetailEditView(seminars: Seminar.seminarsDummy[0], seminarLocation: SeminarLocation(latitude: 37.5665, longitude: 126.9780, address: "서울시청"), seminarData: .constant(Seminar.seminarsDummy[0]), isShowEditView: .constant(true))
    }
}

