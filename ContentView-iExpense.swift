import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

class Expense: ObservableObject {
    @Published var items = [ExpenseItem](){
        didSet{
            if let encoded = try? JSONEncoder().encode(items){
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
        init(){
            if let savedItems = UserDefaults.standard.data(forKey:"Items"){
                if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems){
                    items = decodedItems
                    return
                }
            }
            items = []
        }
    }

struct ContentView: View {
    
    @StateObject private var expenses = Expense()
    @State private var showingAddExpenses = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                        Text(item.type)
                        Text("$\(item.amount, specifier: "%.2f")")
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .navigationBarItems(trailing: Button(action: {
                showingAddExpenses = true
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showingAddExpenses) {
                AddView(expenses: expenses)
            }
        }
    }

    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
