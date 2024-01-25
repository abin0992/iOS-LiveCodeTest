import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = AddressListViewModel()
    @State private var showFilterOptions = false
    @State private var selectedFilter: AddressType? = nil
        
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(AddressType.allCases, id: \.self) { type in
                        Section(header: Text(type.description)) {
                            ForEach(viewModel.filteredAddresses[type] ?? []) { address in
                                AddressView(address: address)
                            }
                        }
                    }
                }

                //._logChanges 
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.5, anchor: .center)
                }
            }
            .navigationTitle("Addresses")
            .navigationBarItems(trailing: Button(action: {
                showFilterOptions = true
            }) {
                Text("Filter")
            })
            .alert(isPresented: Binding<Bool>(
                get: { viewModel.errorMessage != nil },
                set: { _ in viewModel.errorMessage = nil }
            )) {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.errorMessage ?? "An unknown error occurred"),
                    dismissButton: .default(Text("OK"))
                )
            }
            .actionSheet(isPresented: $showFilterOptions) {
                ActionSheet(title: Text("Select Filter"), buttons: filterButtons)
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchAddresses()
            }
        }
    }

    private var filterButtons: [ActionSheet.Button] {
        var buttons = AddressType.allCases.map { type in
            ActionSheet.Button.default(Text(type.description)) {
                selectedFilter = type
                viewModel.applyFilter(type)
            }
        }
        buttons.append(.cancel())
        return buttons
    }
}

struct AddressView: View {
    var address: Address
    
    var body: some View {
        Text(address.displayableAddress)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
