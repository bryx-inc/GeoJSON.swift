//
//  Utilities.swift
//
//  Created by Harlan Haskins on 7/7/15.
//  Copyright (c) 2015 Bryx, Inc. All rights reserved.
//

/// Iterates over a collection, applying `transform` to each element and collecting
/// the results that don't fail.
/// :param: array A type conforming to CollectionType
/// :param: transform A function that takes one argument and yields an optional.
/// :return: An array of the results of applying `transform` to each element in `array`,
/// if the result is not nil.
func mapMaybe<C : CollectionType, T>(array: C, transform: (C.Generator.Element -> T?)) -> [T] {
    var result = [T]()
    for element in array {
        if let transformed = transform(element) {
            result.append(transformed)
        }
    }
    return result
}