//
//  GeoJSONFeatureCollection.swift
//
//  Created by Harlan Haskins on 7/7/15.
//  Copyright (c) 2015 Bryx, Inc. All rights reserved.
//

import Foundation
import CoreLocation

public class GeoJSONFeatureCollection: GeoJSONFeature {

    private(set) var features = [GeoJSONFeature]()
    
    private class func featuresFromDictionary(dictionary: [String: AnyObject]) -> [GeoJSONFeature] {
        var features = [GeoJSONFeature]()
        if let type = dictionary["type"] as? String {
            if type == "GeometryCollection" {
                if let geometries = dictionary["geometries"] as? [[String: AnyObject]] {
                    features += geometries.flatMap { self.featuresFromDictionary($0) }
                }
            } else {
                if let feature = initializerForType(type)?(dictionary) as? GeoJSONFeature {
                    features.append(feature)
                }
            }
        }
        return features
    }
    
    public init(dictionary: [String: AnyObject]) {
        self.features = GeoJSONFeatureCollection.featuresFromDictionary(dictionary)
    }

    public override var dictionaryRepresentation: [String: AnyObject] {
        return [
            "type": "FeatureCollection",
            "features": self.features.map { $0.dictionaryRepresentation }
        ]
    }
    
    private static func initializerForType(type: String) -> ([String: AnyObject] -> AnyObject?)? {
        switch type {
        case GeoJSONPoint.type: return GeoJSONPoint.fromDictionary
        case GeoJSONPolygon.type: return GeoJSONPolygon.fromDictionary
        case GeoJSONMultiPoint.type: return GeoJSONMultiPoint.fromDictionary
        case GeoJSONLineString.type: return GeoJSONLineString.fromDictionary
        case GeoJSONMultiPolygon.type: return GeoJSONMultiPolygon.fromDictionary
        case GeoJSONMultiLineString.type: return GeoJSONMultiLineString.fromDictionary
        default: return nil
        }
    }
}
