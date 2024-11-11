//
//  DIContainer.swift
//  DIContainer
//
//  Created by Abhilash Palem on 11/11/24.
//

public class DIContainer: @unchecked Sendable {
    var registerStorage = RegisterStorage()
    var resolvedObjects = Protected(value: [ServiceKey: Any]())
    
    public static let standard: DIContainer = DIContainer()
    public init() {}
}







