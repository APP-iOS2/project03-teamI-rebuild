//
//  SeminarMapView.swift
//  TicketLion_Admin
//
//  Created by 나예슬 on 2023/09/06.
//

import SwiftUI
import CoreLocation
import MapKit

struct SeminarMapView: View {
    
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var seminarStore: SeminarStore
    @StateObject var locationManager = LocationManager()
    @State private var location = Location(coordinate: CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780))
    @State private var address = "서울 시청"
    
    @Binding var region: MKCoordinateRegion
    @Binding var clickLocation: Bool
    @Binding var seminarLocation: SeminarLocation
    
    var body: some View {
        NavigationStack{
            VStack {
                Text(address)
                    .font(.subheadline)
                
                ZStack {
                    Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: [location]) { location in
                        MapAnnotation(coordinate: location.coordinate) {
                            MapMarkerDetail()
                        }
                    }
                    .edgesIgnoringSafeArea(.bottom)
                    
                    VStack {
                        ZStack{
                            Text("클릭하면 가운데 장소로 선택됩니다")
                                .foregroundColor(.black)
                                .opacity(0.9)
                            Color.gray
                                .frame(width: 250, height: 30)
                                .opacity(0.25)
                        }
                        .cornerRadius(5)
                        .padding(.top)
                        Spacer()
                        
                        HStack {
                            Spacer()
                            VStack {
                                Spacer()
                                Button(action: {
                                    withAnimation {
                                        region.span.latitudeDelta /= 2
                                        region.span.longitudeDelta /= 2
                                    }
                                }) {
                                    Image(systemName: "plus.magnifyingglass")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .padding()
                                        .background(Color.white)
                                        .clipShape(Circle())
                                        .shadow(color: .black, radius: 3)
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    withAnimation {
                                        region.span.latitudeDelta *= 2
                                        region.span.longitudeDelta *= 2
                                    }
                                }) {
                                    Image(systemName: "minus.magnifyingglass")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .padding()
                                        .background(Color.white)
                                        .clipShape(Circle())
                                        .shadow(color: .black, radius: 3)
                                }
                                Spacer()
                            }
                            .frame(height: 150)
                        } // Zoom In/Out 버튼
                        .padding(.init(top: 0, leading: 0, bottom: -50, trailing: 15))
                        
                        Spacer()
                        
                        HStack {
                            Spacer()
                            
                            Button(action: {
                                if let userLocation = locationManager.location?.coordinate {
                                    withAnimation {
                                        region.center = userLocation
                                        drawMarkerWithAddress()
                                    }
                                }
                            }) {
                                Image(systemName: "location.fill")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .bold()
                                    .padding()
                                    .background(Color.white)
                                    .clipShape(Circle())
                                    .shadow(color: .black, radius: 3)
                            }
                        } // 현재 위치 추적 버튼
                        .padding(.init(top: 0, leading: 0, bottom: 40, trailing: 15))
                    }
                } // Zstack(맵뷰)
                .onAppear {
                    drawMarkerWithAddress()
                }
                .onTapGesture {
                    drawMarkerWithAddress()
                }
                
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Text("취소")
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            dismiss()
                            clickLocation = true
                            seminarLocation = seminarStore.setLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, address: address)
                        } label: {
                            Text("완료")
                        }
                    }
                }//toolbar
            }
        }
    } //body
    
    func drawMarkerWithAddress() {
        let touchPoint = region.center
        location = Location(coordinate: touchPoint)
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(CLLocation(latitude: touchPoint.latitude, longitude: touchPoint.longitude), preferredLocale: Locale(identifier: "ko_KR")) { placemarks, error in
            if let placemark = placemarks?.first {
                address = [placemark.administrativeArea, placemark.locality, placemark.thoroughfare, placemark.subThoroughfare].compactMap { $0 }.joined(separator: " ")
            }
        }
    }
} // view

//struct Cross: Shape {
//    func path(in rect: CGRect) -> Path {
//        return Path { path in
//            path.move(to: CGPoint(x: rect.midX, y: 15))
//            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY - 15))
//            path.move(to: CGPoint(x: 15, y: rect.midY))
//            path.addLine(to: CGPoint(x: rect.maxX - 15, y: rect.midY))
//            path.move(to: CGPoint(x: rect.midX, y: rect.midY))
//            path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: 10, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: false)
//        }
//    }
//}

struct SeminarMapView_Previews: PreviewProvider {
    static var previews: some View {
        SeminarMapView(seminarStore: SeminarStore(), region: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780), span: MKCoordinateSpan(latitudeDelta: 0.009, longitudeDelta: 0.009))), clickLocation: .constant(false), seminarLocation: .constant(SeminarLocation(latitude: 37.5665, longitude: 126.9780, address: "서울시청")))
    }
}

