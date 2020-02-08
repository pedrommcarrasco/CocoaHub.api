//
//  ArticleTag.swift
//  App
//
//  Created by Pedro Carrasco on 08/02/2020.
//

import Vapor

// MARK: - ArticleTag
enum ArticleTag: String {
    case architecture
    case server
    case business
    case career
    case debugging
    case design
    case gaming
    case language
    case other
    case storage
    case testing
    case tipsAndTricks
    case tooling
    case ui
    case web
    case workflow
}

// MARK: - Content
extension ArticleTag: Content {}
