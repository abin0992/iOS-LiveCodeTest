import Foundation

struct AddressRequest: APIRequest {
    
    let method: HTTPMethod = .get
    let scheme: String = "https"
    let baseURL: String = "thirdfort.github.io"
    let path: String = "/mobileStaticServer/addresses.json"
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = baseURL
        components.path = path
        return components.url
    }
}
