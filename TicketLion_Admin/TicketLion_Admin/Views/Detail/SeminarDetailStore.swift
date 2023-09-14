//
//  SeminarDetailStore.swift
//  TicketLion_Admin
//
//  Created by 최세근 on 2023/09/06.
//

import SwiftUI
import CoreLocation
import MapKit

final class SeminarDetailStore: ObservableObject {
    @Published var seminarDetailStore: [Seminar] = []
        
    
    @Published var seminarIntroduce: [Seminar] = [] // 세미나 소개
    @Published var seminarDate: [Seminar] = [] // 세미나 일시
    @Published var seminarPlace: [Seminar] = [] // 세미나 장소
    
    func setLocation(latitude: Double, longitude: Double, address: String) -> SeminarLocation {
        let location = SeminarLocation(latitude: latitude, longitude: longitude, address: address)
        return location
    }

    
}

struct Location: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

struct SeminarLocation: Identifiable, Codable {
    var id: UUID = UUID()
    let latitude: Double // 위도
    let longitude: Double // 경도
    let address: String // 주소
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last
    }
    class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
        private let locationManager = CLLocationManager()
        @Published var location: CLLocation?
        
        override init() {
            super.init()
            
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            location = locations.last
        }
    }
}

extension Binding {
  func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T> {
    Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
  }
}
