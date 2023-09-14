//
//  SeminarDetailMapView.swift
//  TicketLion_Consumer
//
//  Created by 남현정 on 2023/09/12.
//


import SwiftUI
import MapKit
import CoreLocation

extension MKPointAnnotation: Identifiable{}

struct SeminarDetailMapView: View {
    
    var seminar: Seminar
    
    ///지도MapKit
//    @State var address: String
    @State private var coordinate: CLLocationCoordinate2D?
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.39494, longitude: 127.110106), // 초기 지도 표시 위치 (예: 샌프란시스코)
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01) // 초기 확대 수준
    )
    @State private var annotation: MKPointAnnotation?
    private let testAddress: String = "서울 종로구 종로3길"
    
    
    var body: some View {
        //지도지도~ 진형님
        VStack { // interactionModes: []
            Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: [annotation].compactMap { $0 }) { pin in
                //MapMarker(coordinate: pin.coordinate, tint: .red)
                MapAnnotation(coordinate: annotation?.coordinate ?? CLLocationCoordinate2D(latitude: 37.39494, longitude: 127.110106)) {
                    Image("customPin")
                }
            }
            .frame(height: 200)
        }
        .onTapGesture {
            convertAddressToCoordinate(address: seminar.location ?? "location -") { coordinate, error in
                if let coordinate = coordinate {
                    region.center.latitude = coordinate.latitude
                    region.center.longitude = coordinate.longitude
                    annotation = MKPointAnnotation()
                    annotation?.coordinate = coordinate
                    annotation?.title = "목적지"
                    annotation?.subtitle = seminar.location ?? "location -"
                }
            }
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
        .onAppear {
            // 주소를 좌표로 변환하여 지도에 표시
            convertAddressToCoordinate(address: seminar.location ?? "location -") { coordinate, error in
                if let coordinate = coordinate {
                    region.center.latitude = coordinate.latitude
                    region.center.longitude = coordinate.longitude
                    annotation = MKPointAnnotation()
                    annotation?.coordinate = coordinate
                    annotation?.title = "목적지"
                    annotation?.subtitle = seminar.location ?? "location -"
                }
            }
        }
    }
    
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

struct SeminarMapView_Previews: PreviewProvider {
    static var previews: some View {
        SeminarDetailMapView(seminar: Seminar.seminarsDummy[2])
    }
}
