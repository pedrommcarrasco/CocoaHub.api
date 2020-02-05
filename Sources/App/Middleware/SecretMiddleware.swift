//
//  SecretMiddleware.swift
//  App
//
//  Created by Pedro Carrasco on 18/04/2019.
//

import Vapor

// MARK: - SecretMiddleware
final class SecretMiddleware {
    
    // MARK: Constant
    private enum Constant {
        static let incorrectHeaderReason = "Incorrect SECRET_KEY header."
        static let noSecretReason = "No SECRET_KEY set on environment."
    }
    
    // MARK: Private Properties
    private let secret: String
    
    // MARK: Init
    init(with secret: String) {
        self.secret = secret
    }
}

// MARK: - Middleware
extension SecretMiddleware: Middleware {
    
    func respond(to request: Request, chainingTo next: Responder) throws -> EventLoopFuture<Response> {
        guard request.http.headers.firstValue(name: .secret) == secret else {
            throw Abort( .unauthorized, reason: Constant.incorrectHeaderReason)
        }
        
        return try next.respond(to: request)
    }
}

// MARK: - ServiceType
extension SecretMiddleware: ServiceType {
    
    static func makeService(for container: Container) throws -> SecretMiddleware {
        guard let secret = Environment.secret else {
            throw Abort(.internalServerError, reason: Constant.noSecretReason)
        }
        return SecretMiddleware(with: secret)
    }
}
