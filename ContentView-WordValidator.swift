import SwiftUI

struct ContentView: View {
    
    @State private var newWord = ""
    @State private var usedWord = [String]()
    @State private var rootWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var errorStatus = false
    
    var body: some View {
        NavigationView{
            List{
                Section{
                    TextField("Enter Your Name", text: $newWord,onCommit: addNewWord).autocapitalization(.none)
                }
                Section{
                    ForEach(usedWord, id: \.self){ word in
                        HStack{
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }.padding()
            }.navigationTitle(rootWord)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("WordValidator.")
                            .font(.title.bold())
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: startGame) {
                        Label("Restart", systemImage: "arrow.clockwise")
                    }
                }
            }

            .onAppear(perform: startGame)
            .alert(isPresented: $errorStatus) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func addNewWord(){
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else { return }
        
        guard isOrignal(word: answer) else{
            errorWord(title: "Word Already used", message: "Be more Orignal!")
            return
        }
        
        guard isPossible(word: answer) else{
            errorWord(title: "Word not Possible", message: "You cannot spell that word from \(rootWord)")
            return
        }
        
        guard isReal(word: answer) else{
            errorWord(title: "Word not recognized", message: "You cant just make up, You KNOW!")
            return
        }
        
        withAnimation{
            usedWord.insert(answer, at: 0)
        }
        newWord = ""
    }
    
    func startGame(){
        
        usedWord = []
        
        if let startWordURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
        if let startWord = try? String(contentsOf: startWordURL){
            let allWords = startWord.components(separatedBy: "\n")
            rootWord = allWords.randomElement() ?? "SilkWorm"
            return
            }
        }
        fatalError("Could not load the start.txt from the Bundle")
    }
    
    func isOrignal(word: String) -> Bool{
        !usedWord.contains(word)
    }
    
    func isPossible(word: String) -> Bool{
        var tempWord = rootWord
        
        for letter in word{
            if let pos = tempWord.firstIndex(of: letter){
                tempWord.remove(at: pos)
            }else{
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool{
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let missSpelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return missSpelledRange.location == NSNotFound
    }
    
    func errorWord(title: String, message: String){
        errorTitle = title
        errorMessage = message
        errorStatus = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
