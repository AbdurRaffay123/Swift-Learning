//
//  ContentView.swift
//  BetterRest
//
//  Created by hst on 24/07/2025.
//

import SwiftUI
import CoreML

struct ContentView: View {
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    @State private var sleepHours = 8.0
    @State private var wakeup = Date()
    @State private var coffeePerDay = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("🕒 When do you wake up?").font(.headline)) {
                    DatePicker(
                        "Wake Up Time",
                        selection: $wakeup,
                        displayedComponents: .hourAndMinute
                    )
                    .labelsHidden()
                    .datePickerStyle(WheelDatePickerStyle())
                }
                
                Section(header: Text("😴 Desired amount of sleep").font(.headline)) {
                    Stepper("\(sleepHours, specifier: "%.1f") hours", value: $sleepHours, in: 4...12, step: 0.25)
                }
                
                Section(header: Text("☕️ Daily coffee intake").font(.headline)) {
                    Picker("\(coffeePerDay) Cup of Coffee", selection: $coffeePerDay) {
                        ForEach(1..<21) { coffee in
                            Text("\(coffee) cup\(coffee > 1 ? "s" :"")").tag(coffee)
                        }
                    }
                    .pickerStyle(MenuPickerStyle()) // Or MenuPickerStyle(), etc.
                }
            }
            .navigationTitle("BetterRest")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Calculate", action: calculateBedTime)
                }
            }
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text(alertTitle),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    
    func calculateBedTime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeup)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(
                wake: Double(hour + minute),
                estimatedSleep: sleepHours,
                coffee: Double(coffeePerDay)
            )
            
            let sleepTime = wakeup - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            alertTitle = "🛏 Ideal Bedtime"
            alertMessage = formatter.string(from: sleepTime)
        } catch {
            alertTitle = "⚠️ Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
        
        showingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
