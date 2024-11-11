//
//  ThreadSafeLock.swift
//  DIContainer
//
//  Created by Abhilash Palem on 11/11/24.
//

import Foundation

struct ThreadSafeLock {
    private let lock = DispatchSemaphore(value: 1)
    
    func execute<T>(_ closure: () -> T) -> T {
        lock.wait()
        defer {
            lock.signal()
        }
        return closure()
    }
}
