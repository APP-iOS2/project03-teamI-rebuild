//
//  SeminarDetailView.swift
//  TicketLion_Comsumer
//
//  Created by 남현정 on 2023/09/06.
//

import SwiftUI
import MapKit
import CoreLocation


extension MKPointAnnotation: Identifiable{}

struct SeminarDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var isShowingDetail: Bool
    
    var dummy: Seminar
    
    ///하단 신청 버튼 ( 원래.contains("\(dummy.id)") )
    private var attendButtonText: String {
        User.usersDummy[0].appliedSeminars .contains("1") ? "신 청 하 기 " : "이미 신청한 세미나입니다"
    }
    private var attendButtonColor: Color {
        User.usersDummy[0].appliedSeminars .contains("1") ? Color("AnyButtonColor") : .gray
    }
    private var attendButtonDisabled: Bool {
        User.usersDummy[0].appliedSeminars .contains("1") ? false : true
    }

    ///지도MapKit
//    @State var address: String
    @State private var coordinate: CLLocationCoordinate2D?
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780), // 초기 지도 표시 위치 (예: 샌프란시스코)
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01) // 초기 확대 수준
    )
    @State private var annotation: MKPointAnnotation?
    private let testAddress: String = "서울 종로구 종로3길"
    
    ///지도 sheet변수
//    @State private var isShowingSheet: Bool = false
    
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
        VStack {
            ScrollView {
                
                VStack {
                    AsyncImage(url: URL(string: dummy.seminarImage)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: 250)

                    } placeholder: {
                        ProgressView()
                    }
                    .padding()
                    
                    
                    VStack(alignment: .leading) {
                        
                        Text("\(dummy.name)")
                        Text("")
                        
                        VStack(alignment: .leading) {
                            
                            Text("진행 날짜 : \(dateCreator(dummy.registerStartDate)) ~ \(dateCreator(dummy.registerEndDate))")
                            Text("진행 시간 : \(timeCreator(dummy.seminarStartDate)) ~ \(timeCreator(dummy.seminarEndDate))")
                            
//                            Text("모집 기간 : \(dummy.registerStartDate)") //모집기간있으면 좋을 것 같아서 일단 추가
                            
                            if let _ = dummy.location {//오프라인이면
                                
                                Text("장소 : \(dummy.location ?? "location -")")
                            }
                            else {
                                
                                Text("온라인 진행")
                            }
                            
                            Text("주최자 : \(dummy.host)")
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
                            
                            
                            //모집마감 여부 눈에 띄면 좋을 것 같아서 추가
                            if dummy.closingStatus { //마감이면
                                Text(" 모집마감 ")
                                    .foregroundColor(.red)
                                    .border(.red)
                                
                            }else {
                                Text(" 모집중 ")
                                    .foregroundColor(.blue)
                                    .border(.blue)
                            }
                            
                        }

                    }
                    Spacer()
                }
                .padding()
                
                
                
                Divider()
                
                //MARK: 행사소개
                VStack(alignment: .leading) {
                    
                    Text("행사 소개")
                    Text("")
                    
                    Text("상세 : \(dummy.details)")
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
                    
                    Text("모집인원 : \(dummy.maximumUserNumber)")
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
                    
                    Text("모집 기간 : \(dummy.registerStartDate)")
                    
                    
                    Text("진행 날짜 : \(dateCreator(dummy.registerStartDate)) ~ \(dateCreator(dummy.registerEndDate))")
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
                    
                    Text("진행 시간 : \(timeCreator(dummy.registerStartDate)) ~ \(timeCreator(dummy.registerEndDate))")
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
                    
                    
                    if let _ = dummy.location { //오프라인이면
                        HStack {
                            Text("장소 : \(dummy.location ?? "location -")")
                            /*
                            Button(action: {
                                isShowingSheet = true
                                
                            }, label: {
                                Text("위치보기")
                                    .foregroundColor(.white)
                                    .font(.caption)
                            })
                            .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)) //위치 버튼은 buttonStyle .bordered보다 padding이 나은것같습니다.
                            .background(Color("AnyButtonColor"))
                            .cornerRadius(5)
                             */
                        }
                             
                        
                        //지도지도~ 진형님
                        VStack {
                            Map(coordinateRegion: $region, interactionModes: [], showsUserLocation: true, annotationItems: [annotation].compactMap { $0 }) { pin in
                                //MapMarker(coordinate: pin.coordinate, tint: .red)
                                MapAnnotation(coordinate: annotation?.coordinate ?? CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780)) {
                                    Image("customPin")
                                }
                            }
                            .frame(height: 250)
                        }
                        .onTapGesture {
                            convertAddressToCoordinate(address: dummy.location ?? "location -") { coordinate, error in
                                if let coordinate = coordinate {
                                    region.center.latitude = coordinate.latitude
                                    region.center.longitude = coordinate.longitude
                                    annotation = MKPointAnnotation()
                                    annotation?.coordinate = coordinate
                                    annotation?.title = "목적지"
                                    annotation?.subtitle = dummy.location ?? "location -"
                                }
                            }
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                        
                        
                    }else {
                        Text("온라인으로 진행")
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                        
                    }
                    
                    Text("문의하기")
                    Text("전화 : 010-0000-0000")
                        .font(.caption)
                    
                    
                }
                .padding()
                
                Spacer()
    
                
            }
            .navigationTitle("\(dummy.name)")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                // 주소를 좌표로 변환하여 지도에 표시
                convertAddressToCoordinate(address: dummy.location ?? "location -") { coordinate, error in
                    if let coordinate = coordinate {
                        region.center.latitude = coordinate.latitude
                        region.center.longitude = coordinate.longitude
                        annotation = MKPointAnnotation()
                        annotation?.coordinate = coordinate
                        annotation?.title = "목적지"
                        annotation?.subtitle = dummy.location ?? "location -"
                    }
                }
            }
            
            //MARK: 신청버튼
            NavigationLink {
                SeminarAttendView(user: User.usersDummy[0], isShowingDetail: $isShowingDetail)
            } label: {
                Text(attendButtonText)
//                    .frame(maxWidth: .infinity)
                    .font(.title2.bold())
            }
            .frame(width: 380,height: 70) //높이가 너무 긴가..?
            .foregroundColor(.white)
            .background(attendButtonColor)
            .cornerRadius(5)
            .disabled(attendButtonDisabled)
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
//                    isShowingDetail = false
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(Color("AnyButtonColor"))
                }

            }
        }

    }
    //MARK: 함수들
    
    func convertAddressToCoordinate(address: String, completion: @escaping (CLLocationCoordinate2D?, Error?) -> Void) {
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { placemarks, error in
            if let error = error {
                print("Geocoding error: \(error)")
                completion(nil, error)
                return
            }
            
            if let placemark = placemarks?.first {
                let coordinate = placemark.location?.coordinate
                completion(coordinate, nil)
            } else {
                print("No location found for address: \(address)")
                completion(nil, nil)
            }
        }
    }
    
}

struct SeminarDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SeminarDetailView(isShowingDetail: .constant(true), dummy: Seminar.seminarsDummy[0])

        }
    }
}
