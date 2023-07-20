import Foundation

struct EmptyAddress {}

protocol Service {
    func getAddresses() async throws -> [EmptyAddress]
}

final class APIService: Service {
    
    private let client: Client
    
    init(client: Client = APIClient()) {
        self.client = client
    }
    
    func getAddresses() async throws -> [EmptyAddress] {
        return []
    }
    
}
