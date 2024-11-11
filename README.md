# DIContainer
> DIContainer is a simple lightweight dependency injection container which can help resolve tight coupling of Third party/Custom services from the main application.It also promotes testability of the code by injecting the services and resolve as needed.  

DIContainer is composed of below components and communicate with each other for proper functioning of resolving application dependencies:

1. DIContainer
2. Dependency Registering
3. Dependency Resolvable
4. Register Storage 
5. Scope
6. Service Key
7. Service Factory
8. Logger

# Architecture:
![alt text](https://github.com/AbhilashPalem258/NetworkService/blob/main/NetworkService.png)

# Components:
#### DIContainer
DIContainer is the main component that provides us simple functions/API for application to register services and resolve components. DIContainer conforms to Dependency Registering and Dependency Resolvable protcols for providing API for regsitering and resolving dependencies

#### Dependency Registering
Dependency Registering provide all the requirements for registering a service and dependency which can be later resolved. 

#### Dependency Resolvable
Dependency Registering provide all the requirements for resolving a component from the regsitered dependencies or services in a container. 

#### Register Storage
Register Storage is used to store the factories into memory. These factories can be later retrieved to resolve a component for a particular service

#### Scope
Scope is an enum with two possible cases Transient and Shared. This helps the container to either construct a shared or a transient component.

#### Service Key
Service Key is used as a key to store or retrive particular factory when regsitering or resolving components.

#### Service Factory
Service Factory is just a wrapper around the builder or closure provided by the developer for registering Service.

#### Logger
Logger is just used to log all the activities like registering a service and resolving a component in console.

# Usage:
1. Import NetworkService after adding as SPM package
2. Create an instance of NetworkService
3. Call NetworkService API/functions to fetch data or resources.

``` swift
import NetworkService

let NS = NetworkService(
    configuration: NetworkServiceConfiguration(
        requestTimeout: 90,
        baseURL: URL(string: "https://picsum.photos/")!,
        logEnabled: true,
        defaultHeaders: [:]
    )
)

struct StoryBundleListRequest: APIRoutable {
    var parameters: AnyEncodable? = nil
    
    var httpMethod: HTTPMethod {
        .get
    }
        
    var path: String {
        "v2/list?page=2&limit=20"
    }
    
    var headers: [String : String] = [:]
}

Completion handlers:
NS.fetchData(StoryBundleListRequest(), responseType: [StoryBundleMetadata].self) { model, failure in
    <#code#>
}

Combine:
NS.fetchData(StoryBundleListRequest(), responseType: [StoryBundleMetadata].self)

Concurrency:
try await NS.fetchData(StoryBundleListRequest(), responseType: [StoryBundleMetadata].self)
```
