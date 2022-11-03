//
//  ViewController.swift
//  Route Tracker
//
//  Created by Dmitry Belov on 25.10.2022.
//

import UIKit
import GoogleMaps
import CoreLocation

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
// Ростов-Арена
    let coordinate = CLLocationCoordinate2D(latitude: 47.2094188, longitude: 39.7377965)
    
    var marker: GMSMarker?
    var manualMarker: GMSMarker?
    var geocoder: CLGeocoder?
    var locationManager: CLLocationManager?
    var route: GMSPolyline? //маршрут движения - линия
    var routePath:GMSMutablePath?// точка

    override func viewDidLoad() {
        super.viewDidLoad()
        configureMap()
        configureLocationManager()
    }
//MARK: метод - Показ карты
     private func configureMap() {
        let camera = GMSCameraPosition.camera(withTarget: coordinate, zoom: 17)
        mapView.camera = camera //ставим камеру на карту
        mapView.isMyLocationEnabled = true //синяя точка - показывает мою позицию на карте
        mapView.delegate = self
    }
//MARK: метод - Показ синей точки - маршрут
    private func configureLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()//отслеживаение разрешения у юзера
        locationManager?.delegate = self
//        locationManager?.allowsBackgroundLocationUpdates = true//отслеживать координаты не включая телефон
    }
//MARK: методы - Ставим маркер и убираем маркер
    private func addMarker() {
        marker = GMSMarker(position: coordinate)
        
//        let rect = CGRect (x: 0, y: 0, width: 20, height: 20)
//        let view = UIView(frame: rect)
//        view.backgroundColor = .magenta
        
//        marker?.icon = UIImage(named: "фламинго")
//        marker?.icon = UIImage(systemName: "mappin")
//        marker?.icon = GMSMarker.markerImage(with: .magenta)
        
        marker?.title = "Привет, пошли играть!"
        marker?.snippet = "Ростов-Арена"
        marker?.groundAnchor = CGPoint(x: 0.5, y: 0.5) //groundAnchor-земляной якорь
        marker?.map = mapView
        print("Ура! Играем!")
    }
    private func removeMarker() {
        marker?.map = nil //удалить объект с карты
        marker = nil //удалить сам объект
    }
//MARK: кнопка "Отследить" - отрисовывается маршрут
    @IBAction func updateLocation(_ sender: Any) {
        locationManager?.requestLocation() //спрашивает у юзера можно ли использовть его маршрут
        route?.map = nil//очистили старый route
        route = GMSPolyline() //линия
        routePath = GMSMutablePath()//проинициализировать routePath
        route?.map = mapView //добавить на карту
        
        locationManager?.startUpdatingLocation()//вызов функции didUpdateLocations из делегата
        print("Я слежу за тобой")
    }
//MARK: кнопка "Текущее" положение
    @IBAction func currentLocation(_ sender: Any) {
        locationManager?.stopUpdatingLocation()
        locationManager?.requestLocation()
        print("Зафиксировал?! Молодец!")
    }
//MARK: кнопка "Маркер на Арене"
    @IBAction func addMarkerDidTap(_ sender: Any) {
        if marker == nil {
            mapView.animate(toLocation: coordinate)
            addMarker()
            print("Вернемся к Арене, друзья мои!")
        } else {
            removeMarker()
        }
    }
}
//MARK: делегат - отрабатывает нажитие по карте и добавлять новые и новые маркеры
extension MapViewController: GMSMapViewDelegate {

    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print(coordinate)
        let manualMarker = GMSMarker(position: coordinate)
        manualMarker.map = mapView
        manualMarker.title = "Сюда"
        manualMarker.icon = GMSMarker.markerImage(with: .blue)
        print("Отсюда-сюда, отсюда-сюда")
        
        if geocoder == nil { //geocoder - показывает адрес
            geocoder = CLGeocoder()
        }
        geocoder?.reverseGeocodeLocation(CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude), completionHandler: { places, error in print(places?.last)})
    }
}
//MARK: делегат - маршрут
extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        routePath?.add(location.coordinate)//добавили новую точки координат
        route?.path = routePath//отрисовка от точки А до точки Б
        
        let position = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 15)
        mapView.animate(to: position) //камера следит за синей точкой и карта плавно двигается
        
        print(location.coordinate)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

 
