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
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // After 1 second, drop a pin.
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1 * NSEC_PER_SEC)), dispatch_get_main_queue()) {
            self.dropPin()
        }
    }
    
    func dropPin() {
        let geoJSONDictionary: [String: AnyObject] = [
            "coordinates": [-77.595453, 43.155059],
            "type": "Point"
        ]
        if let point = GeoJSONPoint.fromDictionary(geoJSONDictionary) {
            println(point.dictionaryRepresentation)
            self.mapView.setRegion(MKCoordinateRegion(center: point.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.0005, longitudeDelta: 0.0005)), animated: true)
            let annotation = MKPointAnnotation()
            annotation.coordinate = point.coordinate
            self.mapView.addAnnotation(annotation)
        }
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        let view = MKPinAnnotationView()
        view.animatesDrop = true
        return view
    }
}

