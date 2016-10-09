//
//  ViewController.swift
//  GeoJSON
//
//  Created by Harlan Haskins on 07/26/2015.
//  Copyright (c) 2015 Harlan Haskins. All rights reserved.
//

import UIKit
import GeoJSON
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // After 1 second, drop a pin.
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.dropPin()
        }
    }
    
    func dropPin() {
        let geoJSONDictionary: [String: Any] = [
            "coordinates": [-77.595453, 43.155059],
            "type": "Point"
        ]
        guard let point = GeoJSONPoint(dictionary: geoJSONDictionary) else { return }
        print(point.dictionaryRepresentation)
        self.mapView.setRegion(MKCoordinateRegion(center: point.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.0005, longitudeDelta: 0.0005)), animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
            let annotation = MKPointAnnotation()
            annotation.coordinate = point.coordinate
            self.mapView.addAnnotation(annotation)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let view = MKPinAnnotationView()
        view.animatesDrop = true
        if #available(iOS 9.0, *) {
            view.pinTintColor = .green
        }
        return view
    }
}

