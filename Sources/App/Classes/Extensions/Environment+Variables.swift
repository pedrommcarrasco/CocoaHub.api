//
//  Environment+Variables.swift
//  App
//
//  Created by Pedro Carrasco on 18/04/2019.
//

import Vapor

// MARK: - Variables
extension Environment {
    
    static var secret: String? {
        return Environment.get("SECURE_KEY")
    }
    
    static var hostname: String {
        return Environment.get("DATABASE_HOSTNAME") ?? "localhost"
    }
    
    static var url: String? {
        return Environment.get("DATABASE_URL")
    }

    static var user: String {
        return Environment.get("DATABASE_USER") ?? "vapor"
    }
    
    static var password: String {
        return Environment.get("DATABASE_PASSWORD") ?? "password"
    }
    
    static var database: String {
        return Environment.get("DATABASE_DATABASE") ?? "cocoahub"
    }
    
    static var port: Int {
        guard let portString = Environment.get("DATABASE_PORT") else { return 5432 }
        return Int(portString) ?? 5432
    }
    
    
}
