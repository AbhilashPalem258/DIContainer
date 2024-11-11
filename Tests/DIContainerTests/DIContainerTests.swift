import Testing
@testable import DIContainer

@Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    let container = DIContainer()
    container.register(type: DependencyAProtocol.self, label: "DependencyA-01") {
        return DependencyA()
    }
    
    var obj1 = try? container.resolve(type:  DependencyAProtocol.self, scope: .shared, label: "DependencyA-01")
    print(obj1)
    obj1?.increment()
    var obj2 = try? container.resolve(type:  DependencyAProtocol.self, scope: .shared, label: "DependencyA-01")
    print(obj2)
}

protocol DependencyAProtocol {
    func increment()
}

protocol DependencyBProtocol {
    func increment()
}

class DependencyA: DependencyAProtocol {
    var value = 1
    
    func increment() {
        value += 1
    }
}

class DependencyB: DependencyBProtocol {
    var value = 101
    
    func increment() {
        value += 1
    }
}
