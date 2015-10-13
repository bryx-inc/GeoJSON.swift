//
//  GeoJSONFeatureCollection.swift
//  Bryx 911
//
//  Created by Harlan Haskins on 7/7/15.
//  Copyright (c) 2015 Bryx. All rights reserved.
//

import Foundation
import CoreLocation

public struct GeoJSONFeatureCollection: GeoJSONFeature {

    private(set) var features = [GeoJSONFeature]()
    
    private static func featuresFromDictionary(dictionary: [String: AnyObject]) -> [GeoJSONFeature] {
        var features = [GeoJSONFeature]()
        guard let type = dictionary["type"] as? String else { return [] }
        if type == "GeometryCollection" {
            if let geometries = dictionary["geometries"] as? [[String: AnyObject]] {
                features += geometries.flatMap { self.featuresFromDictionary($0) }
            }
        } else {
            if let featureType = featureTypeForType(type), feature = featureType.init(dictionary: dictionary) {
                features.append(feature)
            }
        }
        return features
    }
    
    public init(dictionary: [String: AnyObject]) {
        self.features = GeoJSONFeatureCollection.featuresFromDictionary(dictionary)
    }

    public var dictionaryRepresentation: [String: AnyObject] {
        return [
            "type": "FeatureCollection",
            "features": self.features.map { $0.dictionaryRepresentation }
        ]
    }
    
    private static func featureTypeForType(type: String) -> GeoJSONFeature.Type? {
        switch type {
        case GeoJSONPoint.type: return GeoJSONPoint.self
        case GeoJSONPolygon.type: return GeoJSONPolygon.self
        case GeoJSONMultiPoint.type: return GeoJSONMultiPoint.self
        case GeoJSONLineString.type: return GeoJSONLineString.self
        case GeoJSONMultiPolygon.type: return GeoJSONMultiPolygon.self
        case GeoJSONMultiLineString.type: return GeoJSONMultiLineString.self
        default: return nil
        }
    }
}
