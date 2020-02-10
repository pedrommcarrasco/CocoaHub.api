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
    let latitude: Double
    let longitude: Double

    // MARK: Init
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

// MARK: - Content
extension Coordinates: Content {}
