//
//  Event.swift
//  App
//
//  Created by Pedro Carrasco on 12/04/2019.
//

import Vapor
import FluentPostgreSQL
import Pagination

// MARK: - Event
final class Event {
    
    // MARK: Properties
    var id: Int?
    var name: String
    var logo: String
    var tags: [EventTag]
    var url: String
    var country: String
    var city: String
    var coordinates: Coordinates?
    var startDate: Date
    var endDate: Date
    var isActive: Bool
    
    // MARK: Init
    init(name: String,
         logo: String,
         tags: [EventTag],
         url: String,
         country: String,
         city: String,
         coordinates: Coordinates?,
         startDate: Date,
         endDate: Date,
         isActive: Bool
    ) {

        self.name = name
        self.logo = logo
        self.tags = tags
        self.url = url
        self.country = country
        self.city = city
        self.coordinates = coordinates
        self.startDate = startDate
        self.endDate = endDate
        self.isActive = isActive
    }
}

// MARK: - PostgreSQLModel
extension Event: PostgreSQLModel {
    
    func willCreate(on conn: PostgreSQLConnection) throws -> EventLoopFuture<Event> {
        tags = tags.sorted { $0.rawValue <= $1.rawValue }
        return Future.map(on: conn) { self }
    }
    
    func willUpdate(on conn: PostgreSQLConnection) throws -> EventLoopFuture<Event> {
        tags = tags.sorted { $0.rawValue <= $1.rawValue }
        return Future.map(on: conn) { self }
    }
}

// MARK: - Content
extension Event: Content {}

// MARK: - Migration
extension Event: Migration {}

// MARK: - Parameter
extension Event: Parameter {}

// MARK: - Paginatable
extension Event: Paginatable {}

// MARK: - Update
extension Event {
    
    @discardableResult
    func update(with event: Event) -> Event {
        name = event.name
        logo = event.logo
        tags = event.tags
        url = event.url
        country = event.country
        city = event.city
        coordinates = event.coordinates
        startDate = event.startDate
        endDate = event.endDate
        isActive = event.isActive
        
        return self
    }
}
