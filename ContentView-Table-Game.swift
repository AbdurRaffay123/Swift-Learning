import SwiftUI

struct Question {
    let text: String
    let answer: Int
}

struct ContentView: View {
    @State private var gameStarted = false
    @State private var tableUpTo = 5
    @State private var numberOfQuestions = 5
    @State private var questions = [Question]()
    @State private var currentQuestionIndex = 0
    @State private var userAnswer = ""
    @State private var score = 0
    @State private var showingScore = false

    var body: some View {
        NavigationView {
            VStack {
                if gameStarted {
                    VStack(spacing: 20) {
                        Text("Question \(currentQuestionIndex + 1) of \(numberOfQuestions)")
                            .font(.headline)

                        Text(questions[currentQuestionIndex].text)
                            .font(.largeTitle)

                        TextField("Your answer", text: $userAnswer)
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)

                        Button("Submit") {
                            checkAnswer()
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                } else {
                    Form {
                        Section(header: Text("Practice Tables Up To")) {
                            Stepper("Table: \(tableUpTo)", value: $tableUpTo, in: 2...12)
                        }

                        Section(header: Text("Number of Questions")) {
                            Picker("Questions", selection: $numberOfQuestions) {
                                Text("5").tag(5)
                                Text("10").tag(10)
                                Text("20").tag(20)
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }

                        Button("Start Game") {
                            startGame()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                }
            }
            .padding()
            .navigationTitle("Math Challenge")
            .alert(isPresented: $showingScore) {
                Alert(title: Text("Game Over"), message: Text("You scored \(score) out of \(numberOfQuestions)"), dismissButton: .default(Text("Play Again")) {
                    resetGame()
                })
            }
        }
    }

    func startGame() {
        questions = []
        for _ in 1...numberOfQuestions {
            let num1 = Int.random(in: 1...tableUpTo)
            let num2 = Int.random(in: 1...12)
            let q = Question(text: "\(num1) × \(num2)", answer: num1 * num2)
            questions.append(q)
        }
        currentQuestionIndex = 0
        score = 0
        gameStarted = true
        userAnswer = ""
    }

    func checkAnswer() {
        guard let userInt = Int(userAnswer) else { return }
        if userInt == questions[currentQuestionIndex].answer {
            score += 1
        }

        if currentQuestionIndex + 1 < numberOfQuestions {
            currentQuestionIndex += 1
            userAnswer = ""
        } else {
            showingScore = true
        }
    }

    func resetGame() {
        gameStarted = false
        questions = []
        userAnswer = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
