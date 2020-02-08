//
//  New.swift
//  App
//
//  Created by Pedro Carrasco on 13/04/2019.
//

import Vapor
import FluentPostgreSQL
import Pagination

// MARK: - New
final class New {
    
    // MARK: Properties
    var id: Int?
    var title: String
    var description: String
    var date: Date
    var url: String
    var tags: [String]
    var curator: Person
    
    // MARK: Init
    init(title: String, description: String, date: Date, url: String, tags: [String], curator: Person) {
        self.title = title
        self.description = description
        self.date = date
        self.url = url
        self.tags = tags
        self.curator = curator
    }
}

// MARK: - PostgreSQLModel
extension New: PostgreSQLModel {
    
    func willCreate(on conn: PostgreSQLConnection) throws -> EventLoopFuture<New> {
        tags = Tags.allowedTags(from: tags, of: .new)
        return Future.map(on: conn) { self }
    }
    
    func willUpdate(on conn: PostgreSQLConnection) throws -> EventLoopFuture<New> {
        tags = Tags.allowedTags(from: tags, of: .new)
        return Future.map(on: conn) { self }
    }
}

// MARK: - Content
extension New: Content {}

// MARK: - Migration
extension New: Migration {}

// MARK: - Parameter
extension New: Parameter {}

// MARK: - Paginatable
extension New: Paginatable {}

// MARK: - Update
extension New {
    
    @discardableResult
    func update(with new: NewInput) -> New {
        title = new.title
        description = new.description
        url = new.url
        tags = new.tags
        curator = new.curator
        
        return self
    }
}
