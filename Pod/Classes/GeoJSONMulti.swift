//
//  GeoJSONMultiPolygon.swift
//  Bryx 911
//
//  Created by Harlan Haskins on 7/7/15.
//  Copyright (c) 2015 Bryx. All rights reserved.
//

import Foundation
import CoreLocation

public struct GeoJSONMulti<FeatureType>: GeoJSONFeature where FeatureType: GeoJSONFeature {
    public static var type: String { return "Multi" + FeatureType.type }
    
    public let features: [FeatureType]
    
    public init?(dictionary: [String: Any]) {
        guard let featureArrays = dictionary["coordinates"] as? [Any] else { return nil }
        let features = featureArrays.flatMap { FeatureType.init(dictionary: ["coordinates": $0]) }
        self.init(features: features)
    }
    
    public init(features: [FeatureType]) {
        self.features = features
    }
    
    public var geometryCoordinates: [Any] {
        return self.features.map { $0.geometryCoordinates }
    }
}

public typealias GeoJSONMultiPoint = GeoJSONMulti<GeoJSONPoint>
public typealias GeoJSONMultiPolygon = GeoJSONMulti<GeoJSONPolygon>
public typealias GeoJSONMultiLineString = GeoJSONMulti<GeoJSONLineString>
