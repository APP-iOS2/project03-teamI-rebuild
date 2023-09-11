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
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) private var dismiss
    
    let seminars: Seminar
    @State private var startingPoint = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780), span: MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003))
    @State private var date : Date = Date()
    @State private var isOpenMap: Bool = false
    @State private var clickLocation: Bool = false
    
    @State var seminarLocation: SeminarLocation
    @Binding var seminarData: Seminar
    @State private var introduceText: String = ""
    @State private var imageText: String = ""
    @State private var isShowingAlert: Bool = false

    
    @Binding var isShowEditView: Bool
    private let textLimit: Int = 100
    private let today = Calendar.current.startOfDay(for: Date())
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                //MARK: 소개 글
                VStack(alignment: .center, spacing: 30) {
                    Text("소개 글")
                        .font(.system(size: 30) .bold())
                        .padding(.top, 100)

                    ZStack(alignment: .topLeading) {
                        VStack {
                            TextEditor(text: $introduceText)
                                .keyboardType(.default)
                                .foregroundColor(Color.black)
                                .frame(width: 600, height: 200)
                                .lineSpacing(10)
                                .shadow(radius: 2.0)
                            
                            // 글자제한
                                .onChange(of: self.introduceText, perform: {
                                    if $0.count > textLimit {
                                        self.introduceText = String($0.prefix(textLimit))
                                    }
                                })
                            
                            // TextEditor누르면 키보드 내려감
                                .onTapGesture {
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                }
                            
                            // 글자수 확인
                            VStack(alignment: .trailing) {
                                Spacer()
                                HStack {
                                    Spacer()
                                    Text("\(introduceText.count) / \(textLimit)")
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 220))
                                }
                            }
                            // 글자수 확인
//                            if introduceText.isEmpty {
//                                Text("새로운 세미나 소개 글 작성")
//                                    .lineSpacing(10)
//                                    .foregroundColor(Color.primary.opacity(0.25))
//                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 250))
//                            } // 글자 수 확인
                        }
                    }
                    
                    Divider()
                        .padding(EdgeInsets(top: 100, leading: 0, bottom: 50, trailing: 0))

                    //MARK: 일시
                    Text("일시")
                        .font(.system(size: 30) .bold())
                    
                    DatePicker("모집 마감 날짜 선택", selection: $date, in: self.today..., displayedComponents: .date)
//                        .foregroundColor(.secondary)
//                        선택 시 secondary
                        .datePickerStyle(.compact)
                        .padding(.horizontal, 350)
                    
                    Divider()
                        .padding(EdgeInsets(top: 100, leading: 0, bottom: 50, trailing: 0))
                    //MARK: 장소
                    VStack(alignment: .center) {
                        VStack {
                            Text("장소")
                                .font(.system(size: 30) .bold())
                            Button {
                                isOpenMap.toggle()
                                //                  setRegion()
                            } label: {
                                Label("지역 검색", systemImage: "mappin.and.ellipse")
                            }
                            .padding()
                            
                            if clickLocation {
                                
                                Text(seminarLocation.address)
                                    .font(.body)
                                
                                ZStack(alignment: .center) {
                                    Map(coordinateRegion: $startingPoint,
                                        showsUserLocation: true,
                                        annotationItems: [Location(coordinate:
                                                                    CLLocationCoordinate2D(
                                                                        latitude: seminarLocation.latitude,
                                                                        longitude: seminarLocation.longitude))]) {
                                                                            location in
                                                                            MapMarker(coordinate: location.coordinate)
                                                                        }
                                    
                                }.frame(width: 370, height: 150)
                                    .padding([.leading, .trailing,.bottom])
                            } else {
                                Text("세미나 장소를 선택해주세요")
                                    .font(.body)
                                    .foregroundColor(.gray)
                                //                                    .padding([.leading,.bottom])
                            }
                        }
                        .sheet(isPresented: $isOpenMap) {
                            //요기서 fraction 값 바꾸면 시트 비율조정 가능
                            SeminarDetailMapView(seminarStore: SeminarDetailStore(), region: $startingPoint, clickLocation: $clickLocation, seminarLocation: $seminarLocation).presentationDetents([.fraction(0.75)])
                            
                            // Text(seminars.location ?? "장소가 있어야 함")
                            Divider()
                                .padding(.top, 7)
                        }
                        Divider()
                            .padding(EdgeInsets(top: 100, leading: 0, bottom: 50, trailing: 0))
                        //MARK: 대표 이미지
                        VStack(alignment: .center, spacing: 50) {
                            Text("대표 이미지")
                                .font(.system(size: 30) .bold())

                        }
                        // AsyncImage를 쓰려면 String? 타입이여야함
                        // UIImage 쓰신다는 거 이해 후 다시 작성해야함
//                        if let userImage = seminars.seminarImage {
//                            AsyncImage(url: URL(string: userImage)) { image in
//                                image
//                                    .resizable()
//                                    .clipShape(Circle())
//                                    .aspectRatio(contentMode: .fit)
//                                    .frame(width: 400)
//                            } placeholder: {
//                                ProgressView()
//                            }
//                        } else {
//                            Image(systemName: "person.circle.fill")
//                                .font(.system(size: 150))
//                        }
                        Text("이미지 URL을 입력하세요")
                            .padding()

                        ZStack(alignment: .topLeading) {
                            VStack {
                                TextEditor(text: $imageText)
                                    .keyboardType(.default)
                                    .foregroundColor(Color.black)
                                    .frame(width: 600, height: 70)
                                    .lineSpacing(10)
                                    .shadow(radius: 2.0)
                                
                                // 글자제한
                                    .onChange(of: self.imageText, perform: {
                                        if $0.count > textLimit {
                                            self.imageText = String($0.prefix(textLimit))
                                        }
                                    })
                                
                                // TextEditor누르면 키보드 내려감
                                    .onTapGesture {
                                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                    }
                            }
                            .padding(.bottom, 100)
                        }
                        //MARK: 수정하기
                        Button {
                            
                        } label: {
                            Text("수정하기")
                                .font(.system(size: 30) .bold())
                            
                        }
                        .padding(.bottom, 12)
                        .buttonStyle(.borderedProminent)
                        .alert(isPresented: $isShowingAlert) {
                            Alert(
                                title: Text("선택된 사용자가 정지됩니다."),
                                message: Text("이 작업은 되돌릴 수 없습니다."),
                                primaryButton: .destructive(Text("정지"), action: {
                                    dismiss()
                                }),
                                secondaryButton: .cancel(Text("취소"))
                            )
                        }
                        
                    } // 장소, 이미지 VStack
                      // 이미지 ContextMenu로 처리할지 URLString을 받아서 처리할지 고민
                }
                
                //        func setRegion() {
                //          startingPoint.center.latitude = seminars.location.latitude
                //          startingPoint.center.longitude = seminars.location.longitude
                //        }
                
            }
        }
    }
}

struct SeminarDetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        SeminarDetailEditView(seminars: Seminar.seminarsDummy[0], seminarLocation: SeminarLocation(latitude: 37.5665, longitude: 126.9780, address: "서울시청"), seminarData: .constant(Seminar.seminarsDummy[0]), isShowEditView: .constant(true))
    }
}

