//
//  GeoJSONPoint.swift
//  Bryx 911
//
//  Created by Harlan Haskins on 7/7/15.
//  Copyright (c) 2015 Bryx. All rights reserved.
//

import Foundation
import CoreLocation

public struct GeoJSONPoint: GeoJSONFeature {
    
    public let coordinate: CLLocationCoordinate2D
    
    public static var type: String { return "Point" }
    
    public init?(dictionary: [String: Any]) {
        guard let coordinate = (dictionary["coordinates"] as? [Double])?.coordinateRepresentation , CLLocationCoordinate2DIsValid(coordinate) else { return nil }
        self.init(coordinate: coordinate)
    }
    
    public init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
    
    public var geometryCoordinates: [Any] {
        return self.coordinate.geoJSONRepresentation as [AnyObject]
    }
}

extension GeoJSONPoint: Codable {

    enum CodingKeys: String, CodingKey {
        case coordinate = "coordinates"
        case type
        case properties
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let coordinates = try container.decode([Double].self, forKey: .coordinate)
        self.init(coordinate: CLLocationCoordinate2D(latitude: coordinates[0], longitude: coordinates[1]))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode([coordinate.latitude, coordinate.longitude], forKey: .coordinate)
        try container.encode(GeoJSONPoint.type, forKey: .type)
        let propertiesDict: [String: String] = [:]
        try container.encode(propertiesDict, forKey: .properties)
    }
}
