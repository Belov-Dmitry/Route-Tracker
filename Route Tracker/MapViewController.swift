//
//  ViewController.swift
//  Route Tracker
//
//  Created by Dmitry Belov on 25.10.2022.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    // Ростов-Арена
    let coordinate = CLLocationCoordinate2D(latitude: 47.2094188, longitude: 39.7377965)
    
    var marker: GMSMarker?
    var manualMarker: GMSMarker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureMap()
    }
     private func configureMap() {
// создаем камеру с использованием координат и уровней увеличения
        let camera = GMSCameraPosition.camera(withTarget: coordinate, zoom: 17)
//устанавливаем камеру для карты
        mapView.camera = camera
        mapView.delegate = self
    }
    private func addMarker() {
        let rect = CGRect (x: 0, y: 0, width: 20, height: 20)
        let view = UIView(frame: rect)
        view.backgroundColor = .magenta
        
        marker = GMSMarker(position: coordinate)
       
        //получаем стандартное изображение маркера, перекрасив его
        //устанавливаем как изоббражение маркера
       marker?.icon = GMSMarker.markerImage(with: .magenta)
 
        marker?.map = mapView
 //       marker?.iconView = view
        marker?.title = "Привет, пошли играть!"
        marker?.snippet = "Ростов-Арена"
        marker?.groundAnchor = CGPoint(x: 0.5, y: 0.5)
 //       self.marker = marker
    }
    
    private func removeMarker() {
        marker?.map = nil
        marker = nil
    }
    
    @IBAction func goToArena(_ sender: Any) {
        mapView.animate(toLocation: coordinate)
    }
    
    @IBAction func AddMarkerDidTap(_ sender: UIButton) {
        if marker == nil {
            addMarker()
        } else {
            removeMarker()
        }
    }
}
extension MapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print(coordinate)
 //если маркер уже создан - меняем его позицию
        if let manualMarker = manualMarker {
            manualMarker.position = coordinate
        } else {
 //если маркера нет, то создаем его
            let marker = GMSMarker(position: coordinate)
            marker.map = mapView
            self.manualMarker = marker
        }
    }
}

 
