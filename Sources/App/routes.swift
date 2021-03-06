import Vapor

// MARK: - Routes
public func routes(_ router: Router) throws {
    let controllers: [RouteCollection] = [
        EventsController(),
        NewsController(),
        ArticlesController(),
        ContributorsController(),
        RecommendationsController()
    ]

    try controllers.forEach {
        try router.register(collection: $0)
    }
}
