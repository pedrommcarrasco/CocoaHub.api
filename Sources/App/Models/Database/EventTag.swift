//
//  EventTag.swift
//  App
//
//  Created by Pedro Carrasco on 08/02/2020.
//

import Vapor

// MARK: - Event
enum EventTag: String {
    case callForPapers
    case tickets
}

// MARK: - Content
extension EventTag: Content {}
