import SwiftUI

struct ContentView: View {
    @StateObject private var orders = Order()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Cake Selection")) {
                    Picker("Select the cupcake type", selection: $orders.type) {
                        ForEach(Order.cakeTypes.indices, id: \.self) {
                            Text(Order.cakeTypes[$0])
                        }
                    }

                    Stepper("Number of cakes: \(orders.quantity)", value: $orders.quantity, in: 3...20)
                }

                Section(header: Text("Special Requests")) {
                    Toggle("Any Special Requests?", isOn: $orders.specialRequestEnabled)

                    if orders.specialRequestEnabled {
                        Toggle("Add extra Frosting", isOn: $orders.extraFrosting)
                        Toggle("Add extra Sprinkles", isOn: $orders.addSprinkles)
                    }
                }

                Section {
                    NavigationLink(
                        destination: AddressView(order: orders)
                    ) {
                        Text("Delivery Details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
