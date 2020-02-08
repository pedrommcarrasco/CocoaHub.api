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
    
    static func allowedTags(from tags: [String], of type: TagType) -> [String] {
        return tags
            .compactMap {
                switch type {
                case .event:
                    return Event(rawValue: $0)?.rawValue
                case .new:
                    return New(rawValue: $0)?.rawValue
                case .article:
                    return Article(rawValue: $0)?.rawValue
                }
            }
            .sorted()
    }
}

// MARK: - Tags Definition
private extension Tags {
    
    enum New: String {
        case apple
        case community
        case evolution
        case newsletter
        case podcast
        case press
    }
    
    enum Article: String {
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
    
    enum Event: String {
        case callForPapers
        case tickets
    }
}
