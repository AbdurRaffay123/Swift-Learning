import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                Text("Total Bill: \(order.cost, specifier: "%.2f")")
                    .font(.title)
                
                // Place Order Button
                Button("Place Order") {
                    // You can add real logic here
                    print("Order placed!")
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
        }
        .navigationTitle("Checkout")
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CheckoutView(order: Order())
        }
    }
}
