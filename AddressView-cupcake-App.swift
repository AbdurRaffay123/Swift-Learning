import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order

    var body: some View {
        Form {
            Section(header: Text("Shipping Info")) {
                TextField("Name", text: $order.name)
                TextField("Address", text: $order.address)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }

            Section {
                NavigationLink(destination: CheckoutView(order: order)) {
                    Text("Continue to Checkout")
                }
            }
            .disabled(!order.hasValidAddress)
        }
        .navigationTitle("Delivery Details")
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddressView(order: Order())
        }
    }
}
