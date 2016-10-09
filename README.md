# GeoJSON

A GeoJSON Model for Swift 3.0. Compatible with iOS 8 and up.  For earlier versions of Swift and Xcode 7 please use version 0.2.0

[![Version](https://img.shields.io/cocoapods/v/GeoJSON.svg?style=flat)](http://cocoapods.org/pods/GeoJSON)
[![License](https://img.shields.io/cocoapods/l/GeoJSON.svg?style=flat)](http://cocoapods.org/pods/GeoJSON)
[![Platform](https://img.shields.io/cocoapods/p/GeoJSON.svg?style=flat)](http://cocoapods.org/pods/GeoJSON)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Examples

```rust
let geoJSONDictionary: [String: AnyObject] = [
    "coordinates": [-77.595453, 43.155059],
    "type": "Point"
]
guard let point = GeoJSONPoint(dictionary: geoJSONDictionary) else { return }
print(point.dictionaryRepresentation)
/*
[properties: {
}, geometry: {
    coordinates =     (
        "-77.59545300000001",
        "43.155059"
    );
    type = Point;
}, type: Feature] 
*/
```

## Installation

GeoJSON is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "GeoJSON"
```

## Maintainer

Adam Binsz ([@adambinsz](https://github.com/adambinsz))

## Author

Harlan Haskins ([@harlanhaskins](https://github.com/harlanhaskins))

## License

GeoJSON is available under the MIT license. See the LICENSE file for more info.
