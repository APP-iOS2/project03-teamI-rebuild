//
//  SeminarAddView.swift
//  TicketLion_Admin
//
//  Created by 나예슬 on 2023/09/06.
//

import SwiftUI
import MapKit
import CoreLocation

struct SeminarAddView: View {
    @ObservedObject var seminarStore: SeminarStore
    @State private var name: String = ""
    @State private var seminarImage: String = ""
    @State private var details: String = ""
    @State private var detailLocation: String = ""
    @State private var maximumUserNumber: String = ""
    @State private var registerStartDatePicker = Date()
    @State private var registerEndDatePicker = Date()
    @State private var seminarStartDatePicker = Date()
    @State private var seminarEndDatePicker = Date()
    @State private var selectedImage: UIImage? = nil
    @State private var isImagePickerPresented: Bool = false

    @State var isOpenMap: Bool = false
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780), span: MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003))
    @State var seminarLocation: SeminarLocation = SeminarLocation(latitude: 37.5665, longitude: 126.9780, address: "서울시청")
    @State var clickLocation: Bool = false
    
    var body: some View {
        NavigationStack {
            HStack {
                Spacer()
                
                NavigationLink {
                    
                } label: {
                    Text("등록")
                        .font(.title)
                        .bold()
                }
                .padding(.horizontal, 20)
            }
            .buttonStyle(.bordered)
            
            ScrollView {
                VStack(alignment: .leading) {
                    Text("타이틀")
                        .padding(.top, 30)
                        .bold()
                    
                    TextField("", text: $name)
                        .textFieldStyle(.roundedBorder)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                    
                    Group {
                        Text("신청 기간")
                            .bold()
                            .padding(.top, 30)
                        
                        HStack {
                            Text("시작")
                            DatePicker("Date and Time", selection: $registerStartDatePicker, displayedComponents: [.date, .hourAndMinute])
                                .datePickerStyle(.compact)
                            .labelsHidden()                        }
                        HStack {
                            Text("마감")
                            DatePicker("date select", selection: $registerEndDatePicker, displayedComponents: [.date, .hourAndMinute])
                                .datePickerStyle(.compact)
                                .labelsHidden()
                        }
                    }
                    
                    Group {
                        Text("카테고리")
                            .bold()
                            .padding(.top, 30)
                        
                        CategoryChipContainerView(viewModel: ChipsViewModel())
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
 
                        Text("이미지 URL")
                            .bold()
                            .padding(.top, 60)
                        
                        TextField("", text: $seminarImage)
                            .textFieldStyle(.roundedBorder)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
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
                            isOpenMap.toggle()
                            setRegion()
                        } label: {
                            Label("지역 검색", systemImage: "mappin")
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    
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
                        Text("장소를 선택해주세요")
                            .foregroundColor(.gray)
                    }
                    
                    Group {
                        Text("최대 인원")
                            .bold()
                            .padding(.top, 30)

                        TextField("", text: $maximumUserNumber)
                            .keyboardType(.numberPad)
                            .textFieldStyle(.roundedBorder)
                    }
                    
                    Group {
                        Text("진행 기간")
                            .bold()
                            .padding(.top, 30)
                        
                        HStack {
                            Text("시작")
                            DatePicker("date select", selection: $seminarStartDatePicker, displayedComponents: [.date, .hourAndMinute])
                                .datePickerStyle(.compact)
                                .labelsHidden()
                        }
                        HStack {
                            Text("종료")
                            DatePicker("date select", selection: $seminarEndDatePicker, displayedComponents: [.date, .hourAndMinute])
                                .datePickerStyle(.compact)
                                .labelsHidden()
                        }
                    }
                    
                }
                .font(.title2)
                .padding(.horizontal, 20)
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
}

struct SeminarAddView_Previews: PreviewProvider {
    static var previews: some View {
        SeminarAddView(seminarStore: SeminarStore())
    }
}
