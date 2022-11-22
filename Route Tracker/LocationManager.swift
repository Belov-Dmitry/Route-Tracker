//
//  LocationManager.swift
//  Route Tracker
//
//  Created by Dmitry Belov on 21.11.2022.
//

//import Foundation
//import CoreLocation
//import RxSwift
//
//final class LocationManager: NSObject {
//    static let instance = LocationManager()
//    
//    private override init() {
//        super.init()
//        configureLocationManager()
//    }
//    
//    let locationManager = CLLocationManager()
//    let location = PublishSubject <CLLocation>()
//    
//    func startUpdatingLocation() {
//        locationManager.startUpdatingLocation()
//    }
//
//    func stopUpdatingLocation() {
//        locationManager.stopUpdatingLocation()
//    }
//    
//    private func configureLocationManager() {
////        locationManager = CLLocationManager()
//        locationManager.delegate = self
//        locationManager.allowsBackgroundLocationUpdates = true//отслеживать координаты не включая телефон
//        locationManager.startMonitoringSignificantLocationChanges()//отслеживает каждые 100метров
//        locationManager.pausesLocationUpdatesAutomatically = false //если объект стоит, то данные не отправляются, а если движется - данный идут
//        locationManager.requestWhenInUseAuthorization()//отслеживаение разрешения у юзера
//        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//    }
//    var allLocations:[CLLocationCoordinate2D] = []
//}
//
//extension LocationManager: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location  = locations.last else {return}
//        self.location.onNext(location)
// //       allLocations.append(location.coordinate)
//        
//        
//        print(location.coordinate)
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print(error)
//    }
//    
//}


//extension LocationManager: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location  = locations.last else {return}
//        self.location.onNext(location)
//    }
//
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print(error)
//    }
//
//}
