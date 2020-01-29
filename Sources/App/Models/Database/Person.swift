//
//  Contributor.swift
//  App
//
//  Created by Pedro Carrasco on 14/04/2019.
//

import Vapor

// MARK: - Person
final class Person {
    
    // MARK: Properties
    let name: String
    let url: String
    
    // MARK: Init
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}

// MARK: - Content
extension Person: Content {}

// MARK: - Comparable
extension Person: Comparable {
    
    static func < (lhs: Person, rhs: Person) -> Bool {
        return lhs.name < rhs.name
    }
    
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.name == rhs.name
    }
}

// MARK: - Comparable
extension Person: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(url)
    }
}
