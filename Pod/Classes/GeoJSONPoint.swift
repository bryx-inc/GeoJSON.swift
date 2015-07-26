//
//  GeoJSONPoint.swift
//
//  Created by Harlan Haskins on 7/7/15.
//  Copyright (c) 2015 Bryx, Inc. All rights reserved.
//

import Foundation
import CoreLocation

public class GeoJSONPoint: GeoJSONFeature {
    
    public let coordinate: CLLocationCoordinate2D
    
    public override class var type: String { return "Point" }
    
    public override class func fromDictionary(dictionary: [String: AnyObject]) -> GeoJSONPoint? {
        if let coordinate = (dictionary["coordinates"] as? [Double])?.coordinateRepresentation
            where CLLocationCoordinate2DIsValid(coordinate) {
                return GeoJSONPoint(coordinate: coordinate)
        }
        return nil
    }
    
    public init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
    
    public override var geometryCoordinates: [AnyObject] {
        return self.coordinate.geoJSONRepresentation
    }
}
