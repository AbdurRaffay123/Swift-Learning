//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by hst on 24/07/2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["US", "UK", "France", "Germany", "Estonia", "Ireland","Italy", "Nigeria", "Poland", "Spain", "Ukraine"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var ShowingScore = false
    @State private var ScoreTitle = ""
    @State private var Score = 0
    
    var body: some View {
        ZStack{
            LinearGradient(
                gradient: Gradient(colors: [Color.blue, Color.black]),
                startPoint: .top,
                endPoint: .bottom
            ).ignoresSafeArea()
        VStack(spacing: 30){
            VStack(spacing: 10){
                Text("Tag the flag of")
                    .foregroundColor(.white).font(.subheadline.weight(.heavy))
                
                Text(countries[correctAnswer])
                    .foregroundColor(.white)
                    .font(.largeTitle.bold())
            }
            ForEach(0..<3){number in
                Button{
                    flagTapped(number)
                }label:{
                    Image(countries[number])
                        .clipShape(Capsule())
                        .shadow(radius: 5)
                    }
                }
            }
        }
        .alert(isPresented: $ShowingScore) {
            Alert(
                title: Text(ScoreTitle),
                message: Text("Your score is \(Score)"),
                dismissButton: .default(Text("Continue"), action: askQuestion)
            )
        }
    }
    
    func flagTapped(_ number: Int){
        if number == correctAnswer{
            ScoreTitle = "Correct"
            Score+=1
        }else{
            ScoreTitle = "Wrong"
        }
        ShowingScore = true
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
