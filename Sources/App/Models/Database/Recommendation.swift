//
//  Recommendation.swift
//  App
//
//  Created by Pedro Carrasco on 14/04/2019.
//

import Vapor
import FluentPostgreSQL

// MARK: - Recommendation
final class Recommendation {
    
    // MARK: Properties
    var id: Int?
    var logo: String
    var name: String
    var description: String
    var url: String
    
    // MARK: Init
    init(logo: String, name: String, description: String, url: String) {
        self.logo = logo
        self.name = name
        self.description = description
        self.url = url
    }
}

// MARK: - PostgreSQLModel
extension Recommendation: PostgreSQLModel {}

// MARK: - Content
extension Recommendation: Content {}

// MARK: - Migration
extension Recommendation: Migration {}

// MARK: - Parameter
extension Recommendation: Parameter {}

// MARK: - Update
extension Recommendation {
    
    @discardableResult
    func update(with recommendation: Recommendation) -> Recommendation {
        logo = recommendation.logo
        name = recommendation.name
        description = recommendation.description
        url = recommendation.url
        
        return self
    }
}
