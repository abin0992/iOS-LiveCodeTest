import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

protocol APIRequest {
    var method: HTTPMethod { get }
    var scheme: String { get }
    var baseURL: String { get } // host
    var path: String { get }
    var url: URL? { get }
}
