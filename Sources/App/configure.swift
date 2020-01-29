import FluentPostgreSQL
import Vapor

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
    var databases = DatabasesConfig()
    let databaseConfig = PostgreSQLDatabaseConfig(
        hostname: Environment.hostname,
        username: Environment.user,
        database: Environment.database,
        password: Environment.password
    )
    
    let database = PostgreSQLDatabase(config: databaseConfig)
    databases.add(database: database, as: .psql)
    services.register(databases)
    
    /// Configure middleware
    services.register { c -> MiddlewareConfig in
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
