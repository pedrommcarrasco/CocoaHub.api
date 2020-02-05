//
//  HTTPHeaderName+Secret.swift
//  App
//
//  Created by Pedro Carrasco on 18/04/2019.
//

import Vapor

// MARK: - Secret
extension HTTPHeaderName {

    static var secret: HTTPHeaderName {
        return HTTPHeaderName("SECRET_KEY")
    }
}
