import Foundation

protocol Client {
    func execute<V: Codable>(request: APIRequest) async throws -> [V]
}

final class APIClient: Client {
    
    enum Error: Swift.Error {
        case invalidURL
        case dataNotFetched
        case invalidDataFormat
    }
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func execute<V: Codable>(request: APIRequest) async throws -> [V] {
    
        guard let url = request.url else {
            print("invalidURL: \(String(describing: request.url))")
            throw Error.invalidURL
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue

        let (data, response) = try await urlSession.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse,
           httpResponse.statusCode == 200 else {
            throw Error.dataNotFetched
        }
        
        do {
            return try JSONDecoder().decode([V].self,
                                            from: data)
        } catch {
            throw Error.invalidDataFormat
        }

    }
    
}
