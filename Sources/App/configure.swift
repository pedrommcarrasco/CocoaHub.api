import FluentPostgreSQL
import Vapor

extension PostgreSQLDatabaseConfig {
    
    static func make() -> PostgreSQLDatabaseConfig {
        return makeWithURL() ?? makeWithoutURL()
    }
    
    private static func makeWithURL() -> PostgreSQLDatabaseConfig? {
        guard let url = Environment.url else { return nil }
        return PostgreSQLDatabaseConfig(url: url, transport: PostgreSQLConnection.TransportConfig.unverifiedTLS)
    }
    
    private static func makeWithoutURL() -> PostgreSQLDatabaseConfig {
        return PostgreSQLDatabaseConfig(
            hostname: Environment.hostname,
            port: Environment.port,
            username: Environment.user,
            database: Environment.database,
            password: Environment.password
        )
    }
}

// MARK: - Configure
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    // Register providers
    try services.register(FluentPostgreSQLProvider())
    
    // Register routes to the router
    services.register(Router.self) { c -> EngineRouter in
        let router = EngineRouter.default()
        try routes(router)
        return router
    }
    
    // Register middleware
    services.register(LogMiddleware.self)
    services.register(SecretMiddleware.self)
    
    // Configure a database
    let database = PostgreSQLDatabase(config: .make())
    var databasesConfig = DatabasesConfig()
    databasesConfig.add(database: database, as: .psql)
    services.register(databasesConfig)
    
    /// Configure middleware
    services.register { _ -> MiddlewareConfig in
        var middleware = MiddlewareConfig()
        middleware.use(LogMiddleware.self)
        middleware.use(ErrorMiddleware.self)
        return middleware
    }
    
    // Configure migrations
    var migrations = MigrationConfig()
    migrations.add(model: Event.self, database: .psql)
    migrations.add(model: New.self, database: .psql)
    migrations.add(model: ArticlesEdition.self, database: .psql)
    migrations.add(model: Article.self, database: .psql)
    migrations.add(model: Contributor.self, database: .psql)
    migrations.add(model: Recommendation.self, database: .psql)
    services.register(migrations)
    
    // preferences
    config.prefer(ConsoleLogger.self, for: Logger.self)
}
