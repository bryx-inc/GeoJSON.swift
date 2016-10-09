import UIKit
import XCTest
import GeoJSON

class Tests: XCTestCase {
    
    func testPoint() {
        
        let json: [String: Any] = [
            "coordinates": [-104.991531, 39.742043],
            "type": "Point"
        ]
        
        let point = GeoJSONPoint(dictionary: json)!
        let dictionary = point.dictionaryRepresentation["geometry"]!
        // Compiler can't decide what it wants here.  Warning with the `as!` force, error without it
        XCTAssertEqual(json as NSDictionary, dictionary as! NSDictionary)
    }
}
