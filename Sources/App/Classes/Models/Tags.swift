//
//  Tags.swift
//  App
//
//  Created by Pedro Carrasco on 13/04/2019.
//

import Foundation

// MARK: - TagType
enum TagType {
    case event
    case new
    case article
}

// MARK: - Tags
struct Tags {
    
    static func containsInvalidTags(_ tags: [String], for type: TagType) -> Bool {
        switch type {
        case .event:
            return tags.map(Event.init).contains(nil)
        case .new:
            return tags.map(New.init).contains(nil)
        case .article:
            return tags.map(Article.init).contains(nil)
        }
    }
}

// MARK: - Tags Definition
private extension Tags {
    
    enum New: String, CaseIterable {
        case apple
        case community
        case evolution
        case newsletter
        case podcast
        case press
        case other
    }
    
    enum Article: String, CaseIterable {
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
    
    enum Event: String, CaseIterable {
        case callForPapers
        case tickets
        case remote
        case free
    }
}
