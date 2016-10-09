//
//  GeoJSONLineString.swift
//  Bryx 911
//
//  Created by Harlan Haskins on 7/7/15.
//  Copyright (c) 2015 Bryx. All rights reserved.
//

import Foundation
import CoreLocation

public struct GeoJSONLineString: GeoJSONFeature {
    public static var type: String { return "LineString" }
    internal let coordinates: [CLLocationCoordinate2D]
    
    public init?(dictionary: [String: Any]) {
        guard let coordinatePairs = (dictionary["coordinates"] as? [[[Double]]])?.first else { return nil }
        let coordinates = coordinatePairs.flatMap { $0.coordinateRepresentation }
        self.init(coordinates: coordinates)
    }
    
    public init(coordinates: [CLLocationCoordinate2D]) {
        self.coordinates = coordinates
    }
    
    public var geometryCoordinates: [Any] {
        return self.coordinates.map { $0.geoJSONRepresentation }
    }
}
