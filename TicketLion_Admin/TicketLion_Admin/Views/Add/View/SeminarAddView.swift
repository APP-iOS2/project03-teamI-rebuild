//
//  SeminarAddView.swift
//  TicketLion_Admin
//
//  Created by 나예슬 on 2023/09/06.
//

import SwiftUI
import MapKit
import CoreLocation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseCore
import Combine
import FirebaseStorage

struct SeminarAddView: View {
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var seminarStore: SeminarStore
    @ObservedObject var chipsViewModel: ChipsViewModel
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
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented: Bool = false
    @State private var isOnline: Bool = false
    
    var isFieldAllWrite: Bool {
        let currentDate = Calendar.current.startOfDay(for: Date())
        return !name.isEmpty &&
        !host.isEmpty &&
        Calendar.current.startOfDay(for: registerStartDatePicker) != currentDate &&
        Calendar.current.startOfDay(for: registerEndDatePicker) != currentDate &&
        chipsViewModel.chipArray.contains(where: { $0.isSelected}) &&
        !details.isEmpty &&
        !maximumUserNumber.isEmpty &&
        Calendar.current.startOfDay(for: seminarStartDatePicker) != currentDate &&
        Calendar.current.startOfDay(for: seminarEndDatePicker) != currentDate
    }
    
    var db = Firestore.firestore()
    var storage = Storage.storage()
    
    @State var isOpenMap: Bool = false
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.39494, longitude: 127.110106), span: MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003))
    @State var seminarLocation: SeminarLocation = SeminarLocation(latitude: 37.39494, longitude: 127.110106, address: "서울시청")
    @State var clickLocation: Bool = false
    @State var isShowing: Bool = false
    
    static let today = Calendar.current.startOfDay(for: Date())
    
    var body: some View {
        NavigationStack {
            
            ScrollView {
                VStack(alignment: .leading) {
                    Group {
                        Text("타이틀")
                            .padding(.top, 30)
                            .bold()
                        
                        TextField("", text: $name)
                            .textFieldStyle(.roundedBorder)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                        
                        Text("주최자")
                            .padding(.top, 30)
                            .bold()
                        
                        TextField("", text: $host)
                            .textFieldStyle(.roundedBorder)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                    }
                    
                    Group {
                        Text("신청 기간")
                            .bold()
                            .padding(.top, 30)
                        
                        HStack {
                            Text("시작")
                            DatePicker("Date and Time", selection: $registerStartDatePicker,in: Self.today..., displayedComponents: [.date, .hourAndMinute])
                                .datePickerStyle(.compact)
                            .labelsHidden()                        }
                        HStack {
                            Text("마감")
                            DatePicker("date select", selection: $registerEndDatePicker, in: Self.today..., displayedComponents: [.date, .hourAndMinute])
                                .datePickerStyle(.compact)
                                .labelsHidden()
                        }
                    }
                    
                    Group {
                        Text("카테고리")
                            .bold()
                            .padding(.top, 30)
                        
                        CategoryChipContainerView(viewModel: chipsViewModel)
                    }
                    
                    Group {
                        Text("이미지")
                            .bold()
                            .padding(.top, 60)
                        
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
                    
                    Group {
                        Text("상세정보")
                            .bold()
                            .padding(.top, 30)
                        
                        TextEditor(text: $details)
                            .frame(height: 200)
                            .border(Color.gray, width: 1)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                    }
                    
                    Group {
                        Text("장소")
                            .bold()
                            .padding(.top, 30)

                        Button {
                            isOnline.toggle()
                            if isOnline {
                                clickLocation = false
                            }
                        } label: {
                            if isOnline {
                                Label("온라인", systemImage: "checkmark.square.fill")
                            } else if isOnline == false {
                                VStack(alignment: .leading) {
                                    Label("온라인", systemImage: "square")
                                    Button {
                                        isOpenMap.toggle()
                                        setRegion()
                                    } label: {
                                        Label("지역 검색", systemImage: "mappin")
                                            .foregroundColor(.white)
                                    }
                                    .buttonStyle(.borderedProminent)
                                    
                                    Text("지역을 선택해주세요")
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .foregroundColor(.black)
                        .padding(.top, 5)
                        
                        if clickLocation {
                            ZStack(alignment: .center) {
                                Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: [Location(coordinate: CLLocationCoordinate2D(latitude: seminarLocation.latitude, longitude: seminarLocation.longitude))]) { location in
                                    MapMarker(coordinate: location.coordinate)
                                }
                            }.frame(width: 450, height: 250)
                                .padding([.leading, .trailing,.bottom])
                            
                            Text(seminarLocation.address)
                            TextField("상세 주소를 입력해주세요", text: $detailLocation)
                                .textFieldStyle(.roundedBorder)
                                .textInputAutocapitalization(.never)
                                .disableAutocorrection(true)
                        } else {
                            
                        }
                    }
                    
                    Group {
                        Text("최대 인원")
                            .bold()
                            .padding(.top, 30)
                        
                        TextField("", text: $maximumUserNumber)
                            .keyboardType(.numberPad)
                            .textFieldStyle(.roundedBorder)
                            .onReceive(Just(maximumUserNumber)) { newValue in
                                let filtered = newValue.filter { "0123456789".contains($0) }
                                if filtered != newValue {
                                    self.maximumUserNumber = filtered
                                }
                            }
                    }
                    
                    Group {
                        Text("진행 기간")
                            .bold()
                            .padding(.top, 30)
                        
                        HStack {
                            Text("시작")
                            DatePicker("date select", selection: $seminarStartDatePicker, in: registerEndDatePicker..., displayedComponents: [.date, .hourAndMinute])
                                .datePickerStyle(.compact)
                                .labelsHidden()
                        }
                        HStack {
                            Text("종료")
                            DatePicker("date select", selection: $seminarEndDatePicker, in: registerEndDatePicker..., displayedComponents: [.date, .hourAndMinute])
                                .datePickerStyle(.compact)
                                .labelsHidden()
                        }
                    }
                }
                .font(.title2)
                .padding(.horizontal, 20)
                
                Button {
                    isShowing = true
                    fetchSeminar()
                } label: {
                    Text("등록")
                        .font(.title)
                        .foregroundColor(.white)
                        .bold()
                        .padding(.vertical, 20)
                        .frame(maxWidth: .infinity)
                        .background(isFieldAllWrite ? .blue : .secondary)
                }
                .disabled(!isFieldAllWrite)
                .padding(.horizontal, 20)
                .padding(.top, 50)
                .alert(isPresented: $isShowing) {
                    Alert(
                        title: Text(""),
                        message: Text("등록이 완료되었습니다."),
                        dismissButton:
                                .default(Text("확인"),
                                         action: {
                                             dismiss()
                                         })
                    )
                }
            }
            .onTapGesture {
                hideKeyboard()
            }
            .sheet(isPresented: $isOpenMap) {
                SeminarMapView(seminarStore: seminarStore, region: $region, clickLocation: $clickLocation, seminarLocation: $seminarLocation)
                    .presentationDetents([.fraction(0.9)])
            }
            .navigationTitle("세미나 등록")
        }
    }
    
    func setRegion() {
        region.center.latitude = seminarLocation.latitude
        region.center.longitude = seminarLocation.longitude
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func fetchSeminar() {
        
        let selectCategory = chipsViewModel.chipArray.filter { $0.isSelected }.map { $0.titleKey }
        
        var seminar = Seminar(category: selectCategory, name: name, seminarImage: seminarImage, host: host, details: details, location: "\(seminarLocation.address+detailLocation)", maximumUserNumber: Int(maximumUserNumber) ?? 0, createdAt: Date().timeIntervalSince1970, closingStatus: false, registerStartDate: registerStartDatePicker.timeIntervalSince1970, registerEndDate: registerEndDatePicker.timeIntervalSince1970, seminarStartDate: seminarStartDatePicker.timeIntervalSince1970, seminarEndDate: seminarEndDatePicker.timeIntervalSince1970, enterUsers: [])
        
        if let selectedImage {
            guard let imageData = selectedImage.jpegData(compressionQuality: 0.2) else { return }
            
            let storageRef = storage.reference().child(seminar.id)
            
            storageRef.putData(imageData) { _ , error in
                storageRef.downloadURL { url, error in
                    guard let profileImageUrl = url?.absoluteString else { return }
                    seminar.seminarImage = profileImageUrl
                    
                    do {
                        try db.collection("Seminar").document(seminar.id).setData(from: seminar)
                    } catch {
                        
                    }
                    
                }
            }
        }
    }
}

struct SeminarAddView_Previews: PreviewProvider {
    static var previews: some View {
        SeminarAddView(seminarStore: SeminarStore(), chipsViewModel: ChipsViewModel())
    }
}
