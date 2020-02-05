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
        return Environment.get("SECRETKEY")
    }
    
    static var hostname: String {
        return Environment.get("DATABASE_HOSTNAME") ?? "localhost"
    }
    
    static var user: String {
        return Environment.get("DATABASE_USER") ?? "vapor"
    }
    
    static var password: String {
        return Environment.get("DATABASE_PASSWORD") ?? "password"
    }
    
    static var database: String {
        return Environment.get("DATABASE_DB") ?? "cocoahub"
    }
}
