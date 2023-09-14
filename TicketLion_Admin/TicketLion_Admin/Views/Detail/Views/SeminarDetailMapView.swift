//
//  SeminarDetailMapView.swift
//  TicketLion_Admin
//
//  Created by 최세근 on 2023/09/06.
//

import SwiftUI
import CoreLocation
import MapKit

struct SeminarDetailMapView: View {
    
    @Environment(\.dismiss) private var dismiss

    
    @ObservedObject var seminarStore: SeminarDetailStore
    
    @StateObject var locationManager = LocationManager()
    @State private var location = Location(coordinate: CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780))
    @State private var address = "서울 시청"
    
    
//    @Binding var region: MKCoordinateRegion
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780), span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
    @Binding var clickLocation: Bool
    @Binding var seminarLocation: SeminarLocation
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(address)
                    .font(.subheadline)
                
                ZStack {
                    Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: [location]) { location in
                        MapAnnotation(coordinate: location.coordinate) {
                            SeminarMapMarker()
                                .gesture(
                                    DragGesture()
                                        .onChanged { value in
                                            let translation = value.translation
                                            let newCoordinate = CLLocationCoordinate2D(
                                                latitude: location.coordinate.latitude + translation.height * region.span.latitudeDelta / 200.0,
                                                longitude: location.coordinate.longitude + translation.width * region.span.longitudeDelta / 200.0)

                                            
                                            self.location.coordinate = newCoordinate
                                        }
                                        .onEnded { _ in
                                            drawMarkerWithAddress()
                                        }
                                )
                        }
                    }
                    .edgesIgnoringSafeArea(.bottom)
                    
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
                            seminarLocation = seminarStore.setLocation(
                                latitude: location.coordinate.latitude,
                                longitude: location.coordinate.longitude,
                                address: address)
                        } label: {
                            Text("완료")
                        }
                    }
                }//toolbar
            } // 큰 VStack

        } // navigationStack
    } // body
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
} // Struct View

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

struct SeminarDetailMapView_Previews: PreviewProvider {
    static var previews: some View {
        SeminarDetailMapView(seminarStore: SeminarDetailStore(), clickLocation: .constant(false), seminarLocation: .constant(SeminarLocation(latitude: 37.5665, longitude: 126.9780, address: "서울시청")))
    }
}
