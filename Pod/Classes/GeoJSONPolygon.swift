//
//  GeoJSONPolygon.swift
//  Bryx 911
//
//  Created by Harlan Haskins on 7/7/15.
//  Copyright (c) 2015 Bryx. All rights reserved.
//

import Foundation
import CoreLocation

public struct GeoJSONPolygon: GeoJSONFeature {
    public typealias Ring = [CLLocationCoordinate2D]
    public let rings: [Ring]
    
    public static var type: String { return "Polygon" }
    
    public init?(dictionary: [String: Any]) {
        guard let ringArrays = dictionary["coordinates"] as? [[[Double]]] else { return nil }
        let rings = ringArrays.map { $0.flatMap { pair in pair.coordinateRepresentation } }
        self.init(rings: rings)
    }
    
    public init(rings: [Ring]) {
        self.rings = rings
    }
    
    public var geometryCoordinates: [Any] {
        return self.rings.map { $0.map { $0.geoJSONRepresentation } }
    }
}
