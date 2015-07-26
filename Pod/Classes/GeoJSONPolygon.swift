//
//  GeoJSONPolygon.swift
//
//  Created by Harlan Haskins on 7/7/15.
//  Copyright (c) 2015 Bryx, Inc. All rights reserved.
//

import Foundation
import CoreLocation

/// A class representing a GeoJSON Polygon.
/// A polygon consists of multiple 'rings', which are lists of coordinates.
public class GeoJSONPolygon: GeoJSONFeature {
    public typealias Ring = [CLLocationCoordinate2D]
    public let rings: [Ring]
    
    public override class var type: String { return "Polygon" }
    
    public override class func fromDictionary(dict: [String: AnyObject]) -> GeoJSONPolygon? {
        if let ringArrays = dict["coordinates"] as? [[[Double]]] {
            let rings = ringArrays.map { mapMaybe($0) { pair in pair.coordinateRepresentation } }
            return GeoJSONPolygon(rings: rings)
        }
        return nil
    }
    
    public init(rings: [Ring]) {
        self.rings = rings
    }
    
    public override var geometryCoordinates: [AnyObject] {
        return self.rings.map { mapMaybe($0) { $0.geoJSONRepresentation } }
    }
}