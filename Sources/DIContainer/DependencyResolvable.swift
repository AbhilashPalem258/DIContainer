//
//  DependencyResolvable.swift
//  DIContainer
//
//  Created by Abhilash Palem on 11/11/24.
//

import OSLog

protocol DependencyResolvable {
    func resolve<T>(type: T.Type) throws -> T
    func resolve<T>(type: T.Type, label: String) throws -> T
    func resolve<T>(type: T.Type, scope: Scope, label: String) throws -> T
}
extension DIContainer: DependencyResolvable {
    func resolve<T>(type: T.Type) throws -> T {
        return try resolve(type: type, scope: .transient, label: "")
    }
    
    func resolve<T>(type: T.Type, label: String) throws -> T {
        return try resolve(type: type, scope: .transient, label: label)
    }
    
    func resolve<T>(type: T.Type, scope: Scope, label: String) throws -> T {
        let key = ServiceKey(type: type, label: label)
        return try resolve(key: key, scope: scope)
    }
}
private extension DIContainer {
    func resolve<T>(key: ServiceKey, scope: Scope = .transient) throws -> T {
        switch scope {
        case .transient:
            return try resolveTransient(key: key)
        case .shared:
            return try resolveShared(key: key)
        }
    }
    
    func resolveTransient<T>(key: ServiceKey) throws -> T {
        let factory: ServiceFactory<T> = try registerStorage.factory(for: key)
        let component = factory.builder()
        Logger.diLogger.debug("Resolved component for key: \(key.debugDescription)")
        return component
    }
    
    func resolveShared<T>(key: ServiceKey) throws -> T {
        if let existing = resolvedObjects[key], let component = existing as? T {
            return component
        }
        let component: T = try resolveTransient(key: key)
        resolvedObjects[key] = component
        return component
    }
}
