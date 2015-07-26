//
//  GeoJSONLineString.swift
//
//  Created by Harlan Haskins on 7/7/15.
//  Copyright (c) 2015 Bryx, Inc. All rights reserved.
//

import Foundation
import CoreLocation

public class GeoJSONLineString: GeoJSONFeature {
    public override class var type: String { return "LineString" }
    public let coordinates: [CLLocationCoordinate2D]
    
    public override class func fromDictionary(locationDictionary: [String: AnyObject]) -> GeoJSONLineString?  {
        if let
            type = locationDictionary["type"] as? String,
            coordinatePairs = (locationDictionary["coordinates"] as? [[[Double]]])?.first
        where type == self.type {
            let coordinates = mapMaybe(coordinatePairs) { $0.coordinateRepresentation }
            return GeoJSONLineString(coordinates: coordinates)
        }
        return nil
    }
    
    public init(coordinates: [CLLocationCoordinate2D]) {
        self.coordinates = coordinates
    }
    
    public override var geometryCoordinates: [AnyObject] {
        return self.coordinates.map { $0.geoJSONRepresentation }
    }
}