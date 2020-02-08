//
//  NewTag.swift
//  App
//
//  Created by Pedro Carrasco on 08/02/2020.
//

import FluentPostgreSQL

// MARK: - NewTag
enum NewTag: String {
    case apple
    case community
    case evolution
    case newsletter
    case podcast
    case press
}

// MARK: - PostgreSQLEnum
extension NewTag: PostgreSQLEnum {}
