//
//  CLLocationCoordinate2D+Extensions.swift
//  
//
//  Created by Lonnie Gerol on 5/18/22.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D {
    func distanceToCoordinate(_ coordinate: CLLocationCoordinate2D) -> CLLocationDistance {
        let earthRadius = 6371.0 // Earth's radius in Kilometers
        let latDiff = (coordinate.latitude - self.latitude) * (Double.pi/180)
        let lonDiff = (coordinate.longitude - self.longitude) * (Double.pi/180)
        let lat1InRadians = self.latitude * (Double.pi/180)
        let lat2InRadians = coordinate.latitude * (Double.pi/180)
        let nA = pow(sin(latDiff/2), 2) + cos(lat1InRadians) * cos(lat2InRadians) * pow(sin(lonDiff/2), 2)
        let nC = 2 * atan2(sqrt(nA), sqrt(1 - nA))
        let nD = earthRadius * nC
        // convert to meters
        return abs(nD * 1000)
    }
}

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.distanceToCoordinate(rhs) < 0.5
    }
}

extension CLLocationCoordinate2D {
    enum CodingKeys: String, CodingKey {
        case coordinates
    }
}

/**
 conforms to codable and produces json in the form `{ "coordinates": [ lat, long ] }`
 to be consistent with the GeoJSON standard
 */
extension CLLocationCoordinate2D: Codable {
    
    public func encode(to encoder: Encoder) throws {
        let coordArray: [Double] = [self.latitude, self.longitude]
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(coordArray, forKey: .coordinates)
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let coordArray = try values.decode([Double].self, forKey: .coordinates)
        self.init(latitude: coordArray[0], longitude: coordArray[1])
    }
    
}

