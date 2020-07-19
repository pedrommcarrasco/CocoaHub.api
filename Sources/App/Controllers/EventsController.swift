//
//  EventsController.swift
//  App
//
//  Created by Pedro Carrasco on 12/04/2019.
//

import Vapor
import Fluent
import Pagination

// MARK: - EventsController
struct EventsController: RouteCollection {
    
    // MARK: Boot
    func boot(router: Router) throws {
        let routes = router.grouped("events")
        routes.get(use: events)
        routes.get(Event.parameter, use: event)
        routes.get("upcoming", use: upcomingEvent)
        
        routes.group(SecretMiddleware.self) {
            $0.post(Event.self, use: createEvent)
            $0.put(Event.parameter, use: updateEvent)
            $0.delete(Event.parameter, use: deleteEvent)
        }
    }
}

// MARK: - GET
extension EventsController {
    
    func events(_ req: Request) throws -> Future<Paginated<Event>> {
        let today = Date()
        return try Event.query(on: req)
            .group(.and) {
                $0.filter(\.isActive == true)
                $0.filter(\.startDate >= today)
            }
            .paginate(for: req)
    }

    func event(_ req: Request) throws -> Future<Event> {
        return try req.parameters.next(Event.self)
    }
    
    func upcomingEvent(_ req: Request) throws -> Future<Event> {
        let today = Date()
        return Event.query(on: req)
            .group(.and) {
                $0.filter(\.isActive == true)
                $0.filter(\.startDate >= today)
            }
            .sort(\.startDate, .ascending)
            .first()
            .unwrap(or: Abort(.notFound))
    }
}

// MARK: - POST
extension EventsController {
    
    func createEvent(_ req: Request, data: Event) throws -> Future<Event> {
        try data.validate()
        return data.save(on: req)
    }
}

// MARK: - PUT
extension EventsController {
    
    func updateEvent(_ req: Request) throws -> Future<Event> {
        return try flatMap(to: Event.self, req.parameters.next(Event.self), req.content.decode(Event.self)) {
            try $1.validate()
            return $0.update(with: $1).save(on: req)
        }
    }
}

// MARK: - DELETE
extension EventsController {
    
    func deleteEvent(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters
            .next(Event.self)
            .delete(on: req)
            .transform(to: .noContent)
    }
}
