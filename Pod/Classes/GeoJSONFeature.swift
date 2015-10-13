//
//  GeoJSONFeature.swift
//  Bryx 911
//
//  Created by Harlan Haskins on 7/7/15.
//  Copyright (c) 2015 Bryx. All rights reserved.
//

import Foundation
import CoreLocation

public protocol GeoJSONFeature {
    static var type: String { get }
    var geometryCoordinates: [AnyObject] { get }
    var dictionaryRepresentation: [String: AnyObject] { get }
    init?(dictionary: [String: AnyObject])
}

extension GeoJSONFeature {
    public static var type: String { return "Feature" }
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
    public var geometryCoordinates: [AnyObject] {
        return []
    }
    public init?(dictionary: [String: AnyObject]) {
        return nil
    }
}

extension Array {
    var coordinateRepresentation: CLLocationCoordinate2D? {
        guard self.count >= 2 else { return nil }
        guard let latitude = self[1] as? Double, longitude = self[0] as? Double else { return nil }
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

extension CLLocationCoordinate2D {
    var geoJSONRepresentation: [Double] {
        return [self.longitude, self.latitude]
    }
}