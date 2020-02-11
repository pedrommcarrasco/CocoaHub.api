//
//  Contributor.swift
//  App
//
//  Created by Pedro Carrasco on 12/05/2019.
//

import Vapor
import FluentPostgreSQL
import Pagination

// MARK: - Contributor
final class Contributor {
    
    // MARK: Properties
    var id: Int?
    var name: String
    var url: String
    
    // MARK: Init
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}

// MARK: - PostgreSQLModel
extension Contributor: PostgreSQLModel {}

// MARK: - Content
extension Contributor: Content {}

// MARK: - Migration
extension Contributor: Migration {}

// MARK: - Parameter
extension Contributor: Parameter {}

// MARK: - Paginatable
extension Contributor: Paginatable {

    static var defaultPageSorts: [PostgreSQLOrderBy] {
        return [
            (\Contributor.name).querySort(.ascending)
        ]
    }
}

// MARK: - Validatable
extension Contributor: Validatable {
    
    static func validations() throws -> Validations<Contributor> {
        var validations = Validations(Contributor.self)
        try validations.add(\.url, .url)
        return validations
    }
}

// MARK: - Update
extension Contributor {
    
    @discardableResult
    func update(with contributor: Contributor) -> Contributor {
        name = contributor.name
        url = contributor.url

        return self
    }
}
