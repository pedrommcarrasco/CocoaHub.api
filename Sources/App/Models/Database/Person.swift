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

// MARK: - Reflectable
extension Person: Reflectable {}

// MARK: - Validatable
extension Person: Validatable {
    
    static func validations() throws -> Validations<Person> {
        var validations = Validations(Person.self)
        try validations.add(\.name, .count(0..<254))
        try validations.add(\.url, .url)
        return validations
    }
}

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
