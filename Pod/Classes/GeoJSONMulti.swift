//
//  GeoJSONMultiPolygon.swift
//
//  Created by Harlan Haskins on 7/7/15.
//  Copyright (c) 2015 Bryx, Inc. All rights reserved.
//

import Foundation
import CoreLocation

public class GeoJSONMulti<FeatureType where FeatureType: GeoJSONFeature>: GeoJSONFeature {
    public override class var type: String { return "Multi" + FeatureType.type }
    
    public let features: [FeatureType]
    
    public override class func fromDictionary(locationDictionary: [String: AnyObject]) -> Self?  {
        if let featureArrays = locationDictionary["coordinates"] as? [AnyObject] {
            let features = mapMaybe(featureArrays) { FeatureType.fromDictionary(["coordinates": $0]) }
            return self(features: features)
        }
        return nil
    }
    
    public required init(features: [FeatureType]) {
        self.features = features
    }
    
    public override var geometryCoordinates: [AnyObject] {
        return self.features.map { $0.geometryCoordinates }
    }
}

public typealias GeoJSONMultiPoint = GeoJSONMulti<GeoJSONPoint>
public typealias GeoJSONMultiPolygon = GeoJSONMulti<GeoJSONPolygon>
public typealias GeoJSONMultiLineString = GeoJSONMulti<GeoJSONLineString>