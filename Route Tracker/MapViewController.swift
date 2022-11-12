//
//  ViewController.swift
//  Route Tracker
//
//  Created by Dmitry Belov on 25.10.2022.
//

import UIKit
import GoogleMaps
import CoreLocation
import RealmSwift

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
    var allLocations:[CLLocationCoordinate2D] = []
    var locationRealm = LocationRealm()
    
    var isUpdatedLocation = false
    

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
        locationManager?.delegate = self
        locationManager?.allowsBackgroundLocationUpdates = true//отслеживать координаты не включая телефон
        locationManager?.startMonitoringSignificantLocationChanges()//отслеживает каждые 100метров
        locationManager?.pausesLocationUpdatesAutomatically = false //если объект стоит, то данные не отправляются, а если движется - данный идут
        locationManager?.requestWhenInUseAuthorization()//отслеживаение разрешения у юзера
    }
//MARK: методы - Ставим маркер и убираем маркер
    private func addMarker() {
        marker = GMSMarker(position: coordinate)
        
//        let rect = CGRect (x: 0, y: 0, width: 20, height: 20)
//        let view = UIView(frame: rect)
//        view.backgroundColor = .magenta
        
       marker?.icon = UIImage(named: "фламинго")
//        marker?.icon = UIImage(systemName: "mappin")
//        marker?.icon = GMSMarker.markerImage(with: .magenta)
//        let degrees = 90.0
//        marker?.rotation = degrees
        marker?.opacity = 0.5
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

    //MARK: кнопка "К Арене"
    @IBAction func goToArena(_ sender: UIButton) {
        if marker == nil {
            mapView.animate(toLocation: coordinate)
            addMarker()
            print("Вернемся к Арене, друзья мои!")
        } else {
            removeMarker()
        }
    }
        
    //MARK: кнопка "Новый трек"
    @IBAction func startNewTrack(_ sender: Any) {
        isUpdatedLocation = true
        allLocations = []
        locationManager?.requestLocation() //спрашивает у юзера можно ли использовть его маршрут
        route?.map = nil//очистили старый route
        route = GMSPolyline() //линия
        routePath = GMSMutablePath()//проинициализировать routePath
        route?.map = mapView //добавить на карту
        locationManager?.startUpdatingLocation()//вызов функции didUpdateLocations из делегата
        print("Я слежу за тобой")
    }
    
    //MARK: кнопка "Закончить трек"
    @IBAction func stopTracking(_ sender: Any) {
        locationManager?.stopUpdatingLocation()
        self.locationRealm.deleteAllLocations()
        self.locationRealm.addCoordinate(allLocations)
        isUpdatedLocation = false
        print("Я остановился!")
        print(allLocations.count)
        print(allLocations)
        print("end of array")
    }
    
    //MARK: кнопка "Отобразить предыдущий трек"
    @IBAction func showPreviousTrack(_ sender: Any) {
        if isUpdatedLocation {
            let alert = UIAlertController(title: "Сначала останови слежение!", message: "Остановить?", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ОК", style: UIAlertAction.Style.default, handler: {action in
                self.isUpdatedLocation = false
                self.locationManager?.stopUpdatingLocation()
                self.locationRealm.deleteAllLocations()
                self.locationRealm.addCoordinate(self.allLocations)
                self.createPathFromLocations()
            }))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            createPathFromLocations()
        }
    }
    
    
    func createPathFromLocations() {
        route?.map = nil//очистили старый route
        route = GMSPolyline() //линия
        routePath = GMSMutablePath()//проинициализировать routePath
        locationRealm.getAllLocations { locations in
            for location in locations {
                self.routePath?.add(location)
                self.route?.path = routePath
                route?.map = mapView
            }
            let bounds = GMSCoordinateBounds(path: routePath!)
            self.mapView.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 50))
        }
    }
    
    @IBAction func logOut(_ sender: UIStoryboardSegue) {
        print("++++++++++++++++++++++++++++++++++++++++++++")
        print(UserDefaults.standard.bool(forKey: "isLogin"))
        UserDefaults.standard.set(false, forKey: "isLogin")
        print(UserDefaults.standard.bool(forKey: "isLogin"))
        print("---------------------------------------------")
        performSegue(withIdentifier: "toAuth", sender: sender)
        
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
        allLocations.append(location.coordinate)
        routePath?.add(location.coordinate)//добавили новую точку координат
        route?.path = routePath//отрисовка от точки А до точки Б
        
        let position = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 15)
        mapView.animate(to: position) //камера следит за синей точкой и карта плавно двигается
        
        print(location.coordinate)
       
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

 
