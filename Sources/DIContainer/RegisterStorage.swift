//
//  RegisterStorage.swift
//  DIContainer
//
//  Created by Abhilash Palem on 11/11/24.
//

import OSLog

final class RegisterStorage {
    
    var collection = Protected(value: [ServiceKey: Any]())
    
    func add<T>(key: ServiceKey, factory: ServiceFactory<T>) {
        self.collection[key] = factory
        Logger.diLogger.debug("factory added for key: \(key.debugDescription)")
    }
    
    func remove(key: ServiceKey) {
        self.collection[key] = nil
        Logger.diLogger.debug("factory removed for key: \(key.debugDescription)")
    }
    
    func factory<T>(for key: ServiceKey) throws -> ServiceFactory<T> {
        guard let existing = self.collection[key] as? ServiceFactory<T> else {
            Logger.diLogger.error("cannot fetch factory for key: \(key.debugDescription)")
            throw DIContainer.Errors.serviceUnregistered
        }
        Logger.diLogger.debug("fetch factory sucessful for key: \(key.debugDescription)")
        return existing
    }
}
