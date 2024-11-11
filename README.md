# DIContainer
> NetworkService is used to decouple network related functionality from the main application and provides us with a simple interface to perform all network related tasks. 

NetworkService is composed of below components and communicate with each other for proper functioning of network related tasks:

1. Network Service 
2. Network Service Configuration
3. Data Session 
4. Resource Session
5. APIRoutable
6. NetworkAPIFailure
7. Network Logger
8. ResponseValidation
9. The utility extensions or classes which as adapter to communicate with Third Party Dependency/ NetworkClient

# Architecture:
![alt text](https://github.com/AbhilashPalem258/NetworkService/blob/main/NetworkService.png)

# Components:
#### Network Service
NetworkService is the main component that provides us simple functions/API for application to interact. Network Service accepts NetworkServiceConfiguration in initialization and configures data session and resource session based on the configurations provided in NetworkServiceConfiguration

#### Network Service Configuration
NetworkServiceConfiguration holds all the configurations like baseURL, SSL Pinning Keys, default HTTP headers etc.. and it will be injected in to Network Service.

#### Data Session
Data Session is used to communicate for smaller server interactions and fetch data directly in to the memory. 

#### Resource Session
Resource Session is used to fetch images or assets and store data into memory and Disk. It also caches the data with URL as the key.

#### APIRoutable
The instance confirming to APIRoutable should be injected into the function for fetching data or resource from NetworkService. It provides information like URL to fetch, Request HTTP Headers, Parameters to send to Server, HTTP method etc..

#### NetworkAPIFailure
NetworkAPIFailure is a enum with all failures cases that the main application need to act on like No internet, Request Time Out, FailureInParsing etc...

#### Network Logger
Network Logger is used to extract the information from request and response and logs it to the console when a api call happens. This is component is injected into Third Party Networking client and it uses this logger to log the information.

#### Response Validation
Response Validation will be responsible for handling all the application related server response handling like if server sends custom error which needs to show on pop, we will handle it here.

#### Third Party Dependency/ NetworkClient Utilities:
This will contain all the extensions and utilities that acts as adpater for network service to communicate with Network client in a decoupled manner.

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
