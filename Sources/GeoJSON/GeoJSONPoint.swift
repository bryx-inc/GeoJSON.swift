//
//  GeoJSONPoint.swift
//  Bryx 911
//
//  Created by Harlan Haskins on 7/7/15.
//  Copyright (c) 2015 Bryx. All rights reserved.
//

import Foundation
import CoreLocation

public struct GeoJSONPoint: GeoJSONFeature, Codable {
    
    let coordinate: CLLocationCoordinate2D
    let lastUpdated: Date?
    let accuracy: Double?
    
    static public var type: String { return "Point" }
    
    public init?(dictionary: [String: Any]) {
        guard let coordinate = (dictionary["coordinates"] as? [Double])?.coordinateRepresentation, CLLocationCoordinate2DIsValid(coordinate) else { return nil }
        var lastUpdated: Date? = nil
        var accuracy: Double? = nil
        if let properties = dictionary["properties"] as? [String: Any] {
            lastUpdated = (properties["lastUpdated"] as? [String: TimeInterval])?["sec"].map { Date(timeIntervalSince1970: $0) }
            accuracy = properties["accuracy"] as? Double
        }
        self.init(coordinate: coordinate, lastUpdated: lastUpdated, accuracy: accuracy)
    }
    
    init(coordinate: CLLocationCoordinate2D, lastUpdated: Date? = Date(), accuracy: Double? = nil) {
        self.coordinate = coordinate
        self.lastUpdated = lastUpdated
        self.accuracy = accuracy
    }
    
    public var geometryCoordinates: [Any] {
        return self.coordinate.geoJSONRepresentation as [AnyObject]
    }
}

extension GeoJSONPoint: Equatable {
    public static func == (lhs: GeoJSONPoint, rhs: GeoJSONPoint) -> Bool {
        return lhs.coordinate == rhs.coordinate &&
            lhs.lastUpdated == rhs.lastUpdated &&
            lhs.accuracy == rhs.accuracy
    }
}
