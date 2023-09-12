//
//  SeminarDetailStore.swift
//  TicketLion_Admin
//
//  Created by 최세근 on 2023/09/06.
//

import SwiftUI
import CoreLocation
import MapKit
import FirebaseFirestore

final class SeminarDetailStore: ObservableObject {

    @Published var seminarDetailStore: [Seminar] = []
        
    
    @Published var seminarIntroduce: [Seminar] = [] // 세미나 소개
    
    @Published var seminarInfo: [Seminar] = []

//    @Published var seminarDate: [Seminar] = [] // 세미나 일시
//    @Published var seminarPlace: [Seminar] = [] // 세미나 장소
//    @Published var seminarImage: [Seminar] = [] // 세미나 이미지
    let currentDate = Date().timeIntervalSince1970

    var recruitingList: [Seminar] {
        Seminar.seminarsDummy.filter { $0.registerEndDate >= currentDate }
    }
    var closedList: [Seminar] {
        Seminar.seminarsDummy.filter { $0.registerEndDate < currentDate }
    }
    


    func setLocation(latitude: Double, longitude: Double, address: String) -> SeminarLocation {
        let location = SeminarLocation(latitude: latitude, longitude: longitude, address: address)
        return location
    }
    
    
    

//    func fetchSeminar(completion: @escaping (Bool) -> Void) {
//        seminarInfo.removeAll()
//
//        let dataBase = Firestore.firestore().collection("studies")
//        dataBase.getDocuments { snapshot, error in
//            guard let snapshot = snapshot, error == nil else {
//                print("Error fetching data: (error?.localizedDescription ?? ")
//                return
//            }
//
//            for document in snapshot.documents {
//                if let jsonData = try? JSONSerialization.data(withJSONObject: document.data(), options: []),
//                   let seminar = try? JSONDecoder().decode(Seminar.self, from: jsonData) {
//                    self.seminarInfo.append(seminar)
//                    print(seminar)
//
//
//                }
//            }
//
//            completion(true)
//            print("세미나리스트 패치: \(self.seminarInfo)")
//        }
//    }
}



extension String {
    func detailcalculateDate(date: Double) -> String {
        let date = Date(timeIntervalSince1970: date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy.MM.dd"
        return dateFormatter.string(from: date)
    }
}

struct Location: Identifiable {
    let id = UUID()
    var coordinate: CLLocationCoordinate2D
}

struct SeminarLocation: Identifiable, Codable {
    var id: UUID = UUID()
    let latitude: Double // 위도
    let longitude: Double // 경도
    let address: String // 주소
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    @Published var location: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            switch manager.authorizationStatus {
            case .authorizedWhenInUse, .authorizedAlways:
                // 권한이 허용된 경우, 위치 서비스를 활성화하고 위치 업데이트를 시작
                if CLLocationManager.locationServicesEnabled() {
                    locationManager.startUpdatingLocation()
                } else {
                    print("위치 서비스 허용 off")
                }
            case .denied, .restricted:
                // 권한이 거부되거나 제한된 경우, 적절한 조치를 취할 수 있음
                print("위치 서비스 권한이 거부되었거나 제한되었습니다.")
            case .notDetermined:
                // 권한을 아직 설정하지 않은 경우, 여기에서 처리
                break
            @unknown default:
                break
            }
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
