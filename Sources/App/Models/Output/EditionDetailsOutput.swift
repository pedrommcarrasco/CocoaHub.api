//
//  EditionDetails.swift
//  App
//
//  Created by Pedro Carrasco on 30/04/2019.
//

import Vapor

// MARK: - EditionDetailsOutput
final class EditionDetailsOutput {
    
    // MARK: Properties
    let title: String
    let description: String
    let articles: [Article]
    let curators: [Person]
    
    // MARK: Init
    init(edition: ArticlesEdition, articles: [Article]) {
        self.title = edition.title
        self.description = edition.description
        self.articles = articles
        self.curators = Set(articles.map { return $0.curator }).sorted()
    }
}

// MARK: - Content
extension EditionDetailsOutput: Content {}
