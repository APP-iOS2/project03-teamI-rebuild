//
//  SeminarDetailEditView.swift
//  TicketLion_Admin
//
//  Created by 최세근 on 2023/09/06.
//

import SwiftUI
import MapKit
import CoreLocation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseCore
import Combine



struct SeminarDetailEditView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var seminarStores: SeminarDetailStore = SeminarDetailStore()
    @ObservedObject var chipsViewModel: ChipsViewModel
//    @StateObject var seminars: SeminarDetailStore = SeminarDetailStore()
    var seminars: Seminar
    @State private var startingPoint = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.39494, longitude: 127.110106), span: MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003))
    @State private var date : Date = Date()
    @State private var isOpenMap: Bool = false
    @State private var clickLocation: Bool = false
    
    @State var seminarLocation: SeminarLocation
    @Binding var seminarData: Seminar
    
    @State private var seminarText: String = ""
    @State private var introduceText: String = ""
    @State private var imageText: String = ""
    @State private var OrganizerText: String = ""
    @State private var registerText: String = ""

    
    @State private var name: String = ""
    @State private var seminarImage: String = ""
    @State private var host: String = ""
    @State private var details: String = ""
    @State private var detailLocation: String = ""
    @State private var maximumUserNumber: String = ""
    @State private var registerStartDatePicker = Date()
    @State private var registerEndDatePicker = Date()
    @State private var seminarStartDatePicker = Date()
    @State private var seminarEndDatePicker = Date()
    @State private var selectedImage: UIImage? = nil
    @State private var isImagePickerPresented: Bool = false
    
    @State private var isShowingAlert: Bool = false
    @Binding var isShowEditView: Bool
    private let textLimit: Int = 100
    private let today = Calendar.current.startOfDay(for: Date())
    
    let detaildb = Firestore.firestore()
    @State private var isOnline: Bool = false

    
    var body: some View {
        NavigationStack {
            ScrollView {
                //MARK: 세미나 이름
                Text("세미나 이름")
                    .font(.system(size: 30) .bold())
                
                TextEditor(text: $seminarText)
                    .keyboardType(.default)
                    .foregroundColor(Color.black)
                    .frame(width: 950, height: 50)
                    .lineSpacing(10)
                    .shadow(radius: 2.0)
                
                Divider()
                    .padding(EdgeInsets(top: 50, leading: 0, bottom: 50, trailing: 0))
                //MARK: 소개 글
                VStack(alignment: .center, spacing: 30) {
                    Text("소개 글")
                        .font(.system(size: 30) .bold())
                        .padding(.top, 50)
                    
                    ZStack(alignment: .topLeading) {
                        VStack {
                            TextEditor(text: $introduceText)
                                .keyboardType(.default)
                                .foregroundColor(Color.black)
                                .frame(width: 950, height: 200)
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
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 90))
                                }
                            }
                        }
                    }
                    
                    Divider()
                        .padding(EdgeInsets(top: 50, leading: 0, bottom: 50, trailing: 0))
                    
                    //MARK: 주최자
                    VStack {
                        Text("주최자")
                            .font(.system(size: 30) .bold())
                        
                        TextEditor(text: $OrganizerText)
                            .keyboardType(.default)
                            .foregroundColor(Color.black)
                            .frame(width: 950, height: 50)
                            .lineSpacing(10)
                            .shadow(radius: 2.0)
                        
                        Divider()
                            .padding(EdgeInsets(top: 50, leading: 0, bottom: 50, trailing: 0))
                        //MARK: 모집인원
//                        Group {
//                            Text("모집인원")
//                                .font(.system(size: 30) .bold())
//
//                            TextEditor(text: $registerText)
//                                .keyboardType(.default)
//                                .foregroundColor(Color.black)
//                                .frame(width: 950, height: 50)
//                                .lineSpacing(10)
//                                .shadow(radius: 2.0)
//                                .onReceive(Just(maximumUserNumber)) { newValue in
//                                    let filtered = newValue.filter { "0123456789".contains($0) }
//                                    if filtered != newValue {
//                                        self.maximumUserNumber = filtered
//                                    }
//                                }
//                            Divider()
//                                .padding(EdgeInsets(top: 50, leading: 0, bottom: 50, trailing: 0))
//                        }
                        //MARK: 세미나 진행 종료 날짜
                        Group {
                            Text("세미나 진행 종료 날짜")
                                .font(.system(size: 30) .bold())
                            
                            DatePicker("모집 마감 날짜 선택", selection: $date, in: self.today..., displayedComponents: .date)
                            //                        .foregroundColor(.secondary)
                            //                        선택 시 secondary
                                .datePickerStyle(.compact)
                                .padding(.horizontal, 200)
                            
                            Text("선택한 날짜\n \(date.description.detailcalculateDate(date: date.timeIntervalSince1970))")
                                .font(.system(size: 20) .bold())
                            
                            
                            Divider()
                                .padding(EdgeInsets(top: 50, leading: 0, bottom: 50, trailing: 0))
                        }
                        //MARK: 상태
                        Group {
                            Text("마감여부")
                                .font(.system(size: 30) .bold())
                                .padding()
                            Button {
                                isOnline.toggle()
                                if isOnline {
                                    clickLocation = false
                                }
                            } label: {
                                if isOnline {
                                    Label("마감", systemImage: "checkmark.square.fill")
                                        .foregroundColor(.gray)

                                } else if isOnline == false {
                                    Label("마감", systemImage: "square")
                                        .foregroundColor(.gray)
                                }
                            }
                            .font(.title)
                        }
                        
                        Divider()
                            .padding(EdgeInsets(top: 50, leading: 0, bottom: 50, trailing: 0))
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
                                }
                            }
                            .sheet(isPresented: $isOpenMap) {
                                //요기서 fraction 값 바꾸면 시트 비율조정 가능
                                SeminarDetailMapView(seminarStore: SeminarDetailStore(), clickLocation: $clickLocation, seminarLocation: $seminarLocation).presentationDetents([.fraction(0.75)])
                                
                                // Text(seminars.location ?? "장소가 있어야 함")
                                Divider()
                                    .padding(.top, 7)
                            }
                            Divider()
                                .padding(EdgeInsets(top: 50, leading: 0, bottom: 50, trailing: 0))
                            //MARK: 대표 이미지
                            
                            Group {
                                Text("이미지")
                                    .font(.system(size: 30) .bold())
                                
                                Button(action: {
                                    isImagePickerPresented.toggle()
                                }) {
                                    Text("앨범에서 사진 선택")
                                }
                                .buttonStyle(.bordered)
                                .sheet(isPresented: $isImagePickerPresented) {
                                    ImagePickerView(selectedImage: $selectedImage)
                                }
                                
                                if let image = selectedImage {
                                    Image(uiImage: image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 250, height: 250)
                                        .clipShape(Rectangle())
                                }
                            }
                            .padding()
                            //MARK: 수정하기
                            Group {
                                Button {
                                    isShowingAlert = true
                                    updateSeminar()
                                    
                                } label: {
                                    Text("수정하기")
                                        .font(.system(size: 30) .bold())
                                    
                                }
                                .padding(.bottom, 20)
                                .buttonStyle(.borderedProminent)
                                .alert(isPresented: $isShowingAlert) {
                                    Alert(
                                        title: Text("세미나 수정"),
                                        message: Text("수정완료"),
                                        dismissButton:
                                                .default(Text("확인"),
                                                         action: {
                                                             dismiss()
                                                         })
                                    )
                                }
                            }
                            .padding()
                        } // 장소, 이미지 VStack
                    }
                }
            }
        }
    }
    
    //MARK: 파베수정연동
    func updateSeminar() {
        let selectCategory = chipsViewModel.chipArray.filter { $0.isSelected }.map { $0.titleKey }
        
        
        let seminarRef = detaildb.collection("Seminar").document(seminars.id)
  
        let updateData: [String: Any] = [
            "name": seminarText,
            "host": OrganizerText,
            "seminarImage": imageText,
            "details": introduceText,
            "location": "\(seminarLocation.address+detailLocation)",
            "seminarEndDate": date.timeIntervalSince1970,
            "closingStatus": false,
        ]
        // Call updateData on the document reference
        seminarRef.updateData(updateData) { error in
            if let error = error {
                print(error)
            } else {
                print("Document updated successfully")
            }
        }
    }
} // struct

class FirebaseManager {
  static let shared = FirebaseManager()
  let firestore = Firestore.firestore()
}

struct SeminarDetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        SeminarDetailEditView(chipsViewModel: ChipsViewModel(), seminars: Seminar.seminarsDummy[0], seminarLocation: SeminarLocation(latitude: 37.39494, longitude: 127.110106, address: "서울시청"), seminarData: .constant(Seminar.seminarsDummy[0]), isShowEditView: .constant(true))
    }
}

