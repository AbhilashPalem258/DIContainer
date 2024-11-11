//
//  ServiceKey.swift
//  DIContainer
//
//  Created by Abhilash Palem on 11/11/24.
//

struct ServiceKey: Hashable {
    let type: Any.Type
    var label: String?
    
    func hash(into hasher: inout Hasher) {
        ObjectIdentifier(type).hash(into: &hasher)
        hasher.combine(label)
    }
    
    static func == (lhs: ServiceKey, rhs: ServiceKey) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}
extension ServiceKey: CustomDebugStringConvertible {
    var debugDescription: String {
        "Type: \(String(describing: type)), Label: \(label ?? "")"
    }
}
