//
//  GeoJSONFeature.swift
//
//  Created by Harlan Haskins on 7/7/15.
//  Copyright (c) 2015 Bryx, Inc. All rights reserved.
//

import Foundation
import CoreLocation

public class GeoJSONFeature {
    public class var type: String { return "Feature" }
    public var geometryCoordinates: [AnyObject] { return [] }
    public var dictionaryRepresentation: [String: AnyObject] {
        return [
            "geometry": [
                "coordinates": self.geometryCoordinates,
                "type": self.dynamicType.type
            ],
            "type": "Feature",
            "properties": [:]
        ]
    }
    
    public class func fromDictionary(dict: [String: AnyObject]) -> Self? {
        return nil
    }
}

extension Array {
    var coordinateRepresentation: CLLocationCoordinate2D? {
        if self.count >= 2 {
            if let longitude = self[0] as? Double, latitude = self[1] as? Double {
                return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            }
        }
        return nil
    }
}

public extension CLLocationCoordinate2D {
    public var geoJSONRepresentation: [Double] {
        return [self.longitude, self.latitude]
    }
}