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

    public private(set) var features = [GeoJSONFeature]()
    
    public static func featuresFromDictionary(dictionary: [String: Any]) -> [GeoJSONFeature] {
        var features = [GeoJSONFeature]()
        guard let type = dictionary["type"] as? String else { return [] }
        if let geometries = dictionary["geometries"] as? [[String: Any]], type == "GeometryCollection" {
            features += geometries.flatMap { self.featuresFromDictionary(dictionary: $0) }
        } else if let featureType = GeoJSONFeatureCollection.typeMap[type],
                let feature = featureType.init(dictionary: dictionary) {
            features.append(feature)
        }
        return features
    }
    
    public init(dictionary: [String: Any]) {
        self.features = GeoJSONFeatureCollection.featuresFromDictionary(dictionary: dictionary)
    }

    public var dictionaryRepresentation: [String: Any] {
        return [
            "type": "FeatureCollection",
            "features": self.features.map { $0.dictionaryRepresentation }
        ]
    }
    
    static let typeMap: [String: GeoJSONFeature.Type] = [
        GeoJSONPoint.type: GeoJSONPoint.self,
        GeoJSONPolygon.type: GeoJSONPolygon.self,
        GeoJSONMultiPoint.type: GeoJSONMultiPoint.self,
        GeoJSONLineString.type: GeoJSONLineString.self,
        GeoJSONMultiPolygon.type: GeoJSONMultiPolygon.self,
        GeoJSONMultiLineString.type: GeoJSONMultiLineString.self
    ]
}
