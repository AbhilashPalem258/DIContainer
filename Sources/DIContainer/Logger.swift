//
//  Logger.swift
//  DIContainer
//
//  Created by Abhilash Palem on 11/11/24.
//
import OSLog

extension Logger {
    static var subsystem: String { (Bundle.main.bundleIdentifier ?? "App") }
    static let diLogger = Logger(subsystem: subsystem, category: "DIContainer")
}

