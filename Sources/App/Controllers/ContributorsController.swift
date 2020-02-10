//
//  ContributorsController.swift
//  App
//
//  Created by Pedro Carrasco on 12/05/2019.
//

import Vapor
import Fluent
import Pagination

// MARK: - ContributorsController
struct ContributorsController: RouteCollection {
    
    // MARK: Boot
    func boot(router: Router) throws {
        let routes = router.grouped("contributors")
        routes.get(use: contributors)
        routes.get(Contributor.parameter, use: contributor)
        
        routes.group(SecretMiddleware.self) {
            $0.post(Contributor.self, use: createContributor)
            $0.put(Contributor.parameter, use: updateContributor)
            $0.delete(Contributor.parameter, use: deleteContributor)
        }
    }
}

// MARK: - GET
extension ContributorsController {
    
    func contributors(_ req: Request) throws -> Future<Paginated<Contributor>> {
        return try Contributor.query(on: req)
            .groupBy(\.id)
            .sort(\.name)
            .paginate(for: req)
    }

    func contributor(_ req: Request) throws -> Future<Contributor> {
        return try req.parameters.next(Contributor.self)
    }
}

// MARK: - POST
extension ContributorsController {
    
    func createContributor(_ req: Request, data: Contributor) throws -> Future<Contributor> {
        return data.save(on: req)
    }
}

// MARK: - PUT
extension ContributorsController {
    
    func updateContributor(_ req: Request) throws -> Future<Contributor> {
        return try flatMap(to: Contributor.self, req.parameters.next(Contributor.self), req.content.decode(Contributor.self)) {
            return $0.update(with: $1).save(on: req)
        }
    }
}

// MARK: - DELETE
extension ContributorsController {
    
    func deleteContributor(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters
            .next(Contributor.self)
            .delete(on: req)
            .transform(to: .noContent)
    }
}
