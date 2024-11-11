//
//  DependencyRegistering.swift
//  DIContainer
//
//  Created by Abhilash Palem on 11/11/24.
//

protocol DependencyRegistering {
    func register<T>(type: T.Type, _ builder: @escaping () -> T)
    func register<T>(type: T.Type, label: String, _ builder: @escaping () -> T)
}
extension DIContainer: DependencyRegistering {
    func register<T>(type: T.Type, _ builder: @escaping () -> T) {
        registerStorage.add(key: .init(type: type), factory: .init(builder: builder))
    }
    
    func register<T>(type: T.Type, label: String, _ builder: @escaping () -> T) {
        registerStorage.add(key: .init(type: type, label: label), factory: .init(builder: builder))
    }
}
