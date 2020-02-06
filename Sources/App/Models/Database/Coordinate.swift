//
//  Coordinate.swift
//  App
//
//  Created by Pedro Carrasco on 29/01/2020.
//

import Vapor

// MARK: - Coordinates
final class Coordinates {

    // MARK: Properties
    let latitute: Double
    let longitude: Double

    // MARK: Init
    init(latitute: Double, longitude: Double) {
        self.latitute = latitute
        self.longitude = longitude
    }
}

// MARK: - Content
extension Coordinates: Content {}
