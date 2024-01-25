import Foundation

struct EmptyAddress {}

protocol Service {
    func getAddresses() async throws -> [Address]
}

final class APIService: Service {
    
    private let client: Client
    
    init(client: Client = APIClient()) {
        self.client = client
    }
    
    func getAddresses() async throws -> [Address] {
        return try await client.execute(request: AddressRequest())
    }
}
