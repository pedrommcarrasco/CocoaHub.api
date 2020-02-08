//
//  NewInput.swift
//  App
//
//  Created by Pedro Carrasco on 07/08/2019.
//

import Vapor

// MARK: - NewInput
final class NewInput {
    
    // MARK: Properties
    let title: String
    let description: String
    let url: String
    let tags: [NewTag]
    let curator: Person
    
    // MARK: Init
    init(title: String, description: String, url: String, tags: [NewTag], curator: Person) {
        self.title = title
        self.description = description
        self.url = url
        self.tags = tags
        self.curator = curator
    }
}

// MARK: - Content
extension NewInput: Content {}
