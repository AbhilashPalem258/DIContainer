//
//  ServiceFactory.swift
//  DIContainer
//
//  Created by Abhilash Palem on 11/11/24.
//

struct ServiceFactory<T> {
    var builder: () -> T
}
