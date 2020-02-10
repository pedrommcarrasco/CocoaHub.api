//
//  RecommendationsController.swift
//  App
//
//  Created by Pedro Carrasco on 12/05/2019.
//

import Vapor
import Fluent
import Pagination

// MARK: - RecommendationsController
struct RecommendationsController: RouteCollection {
    
    // MARK: Boot
    func boot(router: Router) throws {
        let routes = router.grouped("recommendations")
        routes.get(use: recommendations)

        routes.group(SecretMiddleware.self) {
            $0.post(Recommendation.self, use: createRecommendation)
            $0.put(Recommendation.parameter, use: updateRecommendation)
            $0.delete(Recommendation.parameter, use: deleteRecommendation)
        }
    }
}

// MARK: - GET
extension RecommendationsController {
    
    func recommendations(_ req: Request) -> Future<[Recommendation]> {
        return Recommendation.query(on: req)
            .groupBy(\.id)
            .sort(\.name)
            .all()
    }
}

// MARK: - POST
extension RecommendationsController {
    
    func createRecommendation(_ req: Request, data: Recommendation) throws -> Future<Recommendation> {
        return data.save(on: req)
    }
}

// MARK: - PUT
extension RecommendationsController {
    
    func updateRecommendation(_ req: Request) throws -> Future<Recommendation> {
        return try flatMap(to: Recommendation.self, req.parameters.next(Recommendation.self), req.content.decode(Recommendation.self)) {
            return $0.update(with: $1).save(on: req)
        }
    }
}

// MARK: - DELETE
extension RecommendationsController {
    
    func deleteRecommendation(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters
            .next(Recommendation.self)
            .delete(on: req)
            .transform(to: .noContent)
    }
}
