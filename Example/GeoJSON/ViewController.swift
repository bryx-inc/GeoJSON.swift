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

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewWillAppear(animated: Bool) {
        let geoJSONDictionary = [
            "coordinates": [-77.595453, 43.155059]
        ]
        if let point = GeoJSONPoint.fromDictionary(geoJSONDictionary) {
            self.mapView.setRegion(MKCoordinateRegion(center: point.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.0005, longitudeDelta: 0.0005)), animated: true)
        }
    }
}

