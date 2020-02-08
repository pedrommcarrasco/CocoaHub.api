//
//  Article.swift
//  App
//
//  Created by Pedro Carrasco on 14/04/2019.
//

import Vapor
import FluentPostgreSQL

// MARK: - Article
final class Article {
    
    // MARK: Properties
    var id: Int?
    var title: String
    var tags: [String]
    var url: String
    var author: Person
    var curator: Person
    var edition: ArticlesEdition.ID
    
    // MARK: Init
    init(title: String, tags: [String], url: String, author: Person, curator: Person, edition: ArticlesEdition.ID) {
        self.title = title
        self.tags = tags
        self.url = url
        self.edition = edition
        self.author = author
        self.curator = curator
    }
}

// MARK: - PostgreSQLModel
extension Article: PostgreSQLModel {
    func willCreate(on conn: PostgreSQLConnection) throws -> EventLoopFuture<Article> {
        tags = Tags.allowedTags(from: tags, of: .article)
        return Future.map(on: conn) { self }
    }
    
    func willUpdate(on conn: PostgreSQLConnection) throws -> EventLoopFuture<Article> {
        tags = Tags.allowedTags(from: tags, of: .article)
        return Future.map(on: conn) { self }
    }
}

// MARK: - Content
extension Article: Content {}

// MARK: - Parameter
extension Article: Parameter {}

// MARK: - Migration
extension Article: Migration {
    
    static func prepare(on connection: PostgreSQLConnection) -> Future<Void> {
        return Database.create(self, on: connection) { builder in
            try addProperties(to: builder)
            builder.reference(from: \.edition, to: \ArticlesEdition.id)
        }
    }
}

// MARK: - Update
extension Article {
    
    @discardableResult
    func update(with article: Article) -> Article {
        title = article.title
        tags = article.tags
        url = article.url
        edition = article.edition
        curator = article.curator
        
        return self
    }
}
