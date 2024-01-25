//
//  AddressListViewModel.swift
//  iOS-LiveCode-Test
//
//  Created by Abin Baby on 25.01.24.
//

import Foundation

class AddressListViewModel: ObservableObject {

    @Published var allAddresses: [AddressType: [Address]] = [:]
    @Published var filteredAddresses: [AddressType: [Address]] = [:]
    @Published var errorMessage: String?
    @Published var isLoading: Bool = true

    private let fetchAddressesUseCase: FetchAddressesUseCase
    
    init(
        fetchAddressesUseCase: FetchAddressesUseCase = FetchAddressesUseCase()
    ) {
        self.fetchAddressesUseCase = fetchAddressesUseCase
    }
    
    @MainActor
    func fetchAddresses() async {

        
        isLoading = true
        do {
            let addresses = try await fetchAddressesUseCase.execute()
            await MainActor.run {
                self.allAddresses = addresses
                self.filteredAddresses = addresses
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
            }
        }
        isLoading = false
    }
    
    func applyFilter(_ filter: AddressType?) {
        if let filter {
            if let filteredAddress = allAddresses[filter] {
                filteredAddresses.removeAll()
                filteredAddresses[filter] = filteredAddress
            }
        } else {
            filteredAddresses = allAddresses
        }
    }
}
