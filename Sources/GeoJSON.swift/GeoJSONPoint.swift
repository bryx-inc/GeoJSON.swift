//
//  GeoJSONPoint.swift
//  Bryx 911
//
//  Created by Harlan Haskins on 7/7/15.
//  Copyright (c) 2015 Bryx. All rights reserved.
//

import Foundation
import CoreLocation

public struct GeoJSONPoint: GeoJSONFeature {
    
    public let coordinate: CLLocationCoordinate2D
    
    public static var type: String { return "Point" }
    
    public init?(dictionary: [String: Any]) {
        guard let coordinate = (dictionary["coordinates"] as? [Double])?.coordinateRepresentation , CLLocationCoordinate2DIsValid(coordinate) else { return nil }
        self.init(coordinate: coordinate)
    }
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
    
    public var geometryCoordinates: [Any] {
        return self.coordinate.geoJSONRepresentation as [AnyObject]
    }
}
