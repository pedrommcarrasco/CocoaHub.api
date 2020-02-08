//
//  EventTag.swift
//  App
//
//  Created by Pedro Carrasco on 08/02/2020.
//

import FluentPostgreSQL

// MARK: - Event
enum EventTag: String {
    case callForPapers
    case tickets
}

// MARK: - EventTag
extension EventTag: PostgreSQLEnum {}
