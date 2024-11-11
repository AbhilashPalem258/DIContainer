//
//  Protected.swift
//  DIContainer
//
//  Created by Abhilash Palem on 11/11/24.
//

@dynamicMemberLookup
final class Protected<Value> {
    private let lock = ThreadSafeLock()
    private var value: Value
    
    init(value: Value) {
        self.value = value
    }
    
    subscript<Property>(dynamicMember keyPath: KeyPath<Value, Property>) -> Property {
        lock.execute{ value[keyPath: keyPath] }
    }
    
    subscript<Property>(dynamicMember keyPath: WritableKeyPath<Value, Property>) -> Property {
        get { lock.execute{ value[keyPath: keyPath] } }
        set { lock.execute{ value[keyPath: keyPath] = newValue } }
    }
}
