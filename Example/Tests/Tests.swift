import UIKit
import XCTest
import GeoJSON
import Nimble

class Tests: XCTestCase {
    
    func testPoint() {
        
        let json: [String: Any] = [
            "coordinates": [-104.991531, 39.742043],
            "type": "Point"
        ]
        
        let point = GeoJSONPoint(dictionary: json)!
        let dictionary = point.dictionaryRepresentation["geometry"]!
        expect(json as NSDictionary).to(equal(dictionary as! NSDictionary))
    }
    
}
