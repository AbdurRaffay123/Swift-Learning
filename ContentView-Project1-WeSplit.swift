import SwiftUI

struct ContentView: View {

    @State private var checkAmountString: String = ""
    @State private var numberofpeople: Int = 0
    @State private var tipOptions = [0, 10, 15, 20, 25]
    @State private var tipPercentage = 10
    
    var checkAmount: Double {
           Double(checkAmountString) ?? 0.0
       }
       
       var currencyFormatter: NumberFormatter {
           let formatter = NumberFormatter()
           formatter.numberStyle = .currency
           formatter.locale = Locale.current
           return formatter
       }
    
    var totalPerPerson: Double{
        let PeopleCount = Double(numberofpeople+2)
        let TipSelection = Double(tipPercentage)
        
        let TipValue = checkAmount / 100 * TipSelection
        let GrandTotal = checkAmount + TipValue
        let amountPerPerson = GrandTotal / PeopleCount
        print(GrandTotal)
        return amountPerPerson
    }
    
    
    var body: some View {

        NavigationView {
                    Form {
                        //Enter Amount:
                        Section(header: Text("Enter Amount")) {
                            TextField("Amount", text: $checkAmountString)
                                .keyboardType(.decimalPad)
                        }
                        
                        //Choose no of PPLS:
                        Section(header: Text("Number of People")) {
                        Picker("Choose Number of People", selection: $numberofpeople){
                            ForEach(2..<100) { number in
                                Text("\(number) people")
                                }
                            }
                        }
                        
                        //Get Percentage:
                        Section(header: Text("Choose your Tip Percentage")) {
                            Picker("Tip Percentage", selection: $tipPercentage) {
                                ForEach(tipOptions, id: \.self) { percent in
                                    Text("\(percent)%")
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        
                        //Entered Amount:
                        Section(header: Text("You entered")) {
                            Text(currencyFormatter.string(from: NSNumber(value: totalPerPerson)) ?? "")
                        }
                    }
                    .navigationTitle("WeSplit")
                }
           }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
