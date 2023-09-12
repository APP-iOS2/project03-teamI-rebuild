//
//  SeminarAdd.swift
//  TicketLion_Admin
//
//  Created by 나예슬 on 2023/09/06.
//

import Foundation
import SwiftUI
import CoreLocation
import MapKit

//struct SeminarAdd: Identifiable {
//    var id: String = UUID().uuidString
//    let category: [String]              // 세미나 카테고리는 여러가지..? 그래서 배열? 정해야할듯
//    let name: String                    // 세미나 이름
//    let seminarImage: Image             // 세미나 대표 사진
//    let host: String                    // 세미나 호스트 이름
//    let details: String                 // 세미나 상세 정보
//    let form: Bool                      // 세미나 진행 형태 (오프라인,온라인)
//    let location: String?               // 장소 주소
//    let registerDate: String            // 모집시작날짜 ~ 모집마감날짜 구조체
//    let seminarDate: String             // 세미나시작날짜 ~ 세미나끝날짜 구조체
//    let maximumUserNumber: Int          // 세미나 모집 최대 인원
//    let closingStatus: Bool             // 세미나 마감 여부
//    var registerStartDate: Double       // 세미나 진행 시작 날짜
//    var registerStartTime: Double       // 세미나 진행 시작 시간
//    var registerEndDate: Double         // 세미나 진행 종료 날짜
//    var registerEndTime: Double         // 세미나 진행 종료 시간
//    var registerRunTime: Double         // 세미나 진행시간
//    let enterUsers: [String]            // 세미나 참가 유저
//    let registerIsSelected: Bool        // 세미나 참가여부
//    let registerIsTaped: Bool           // 세미나 게시글 한번이라도 확인했을때 알려주는 Bool값
//}

//struct Location: Identifiable {
//    let id = UUID()
//    let coordinate: CLLocationCoordinate2D
//}
//
//struct SeminarLocation: Identifiable {
//    var id: UUID = UUID()
//    let latitude: Double
//    let longitude: Double
//    let address: String
//}
//
//class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
//    private let locationManager = CLLocationManager()
//    @Published var location: CLLocation?
//    
//    override init() {
//        super.init()
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        location = locations.last
//    }
//    class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
//        private let locationManager = CLLocationManager()
//        @Published var location: CLLocation?
//        
//        override init() {
//            super.init()
//            
//            locationManager.delegate = self
//            locationManager.desiredAccuracy = kCLLocationAccuracyBest
//            locationManager.requestWhenInUseAuthorization()
//            locationManager.startUpdatingLocation()
//        }
//        
//        
//        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//            location = locations.last
//        }
//    }
//}
