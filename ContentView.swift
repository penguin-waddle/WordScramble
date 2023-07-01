import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var userScore = 0
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .autocapitalization(.none)
                }
                Section {
                    ForEach(usedWords, id: \.self) {word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                        .accessibilityElement()
                        .accessibilityLabel(word)
                        .accessibilityHint("\(word.count) letters")
                    }
                }
            }    
                .navigationTitle(rootWord)
                .onSubmit(addNewWord)
                .onAppear(perform:startGame)
                .alert(errorTitle, isPresented: $showingError) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text(errorMessage)
                }
            }
        NavigationStack {
            Spacer()
            Text("Your score is \(userScore)!")
                .foregroundColor(.secondary)
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Button("New Word") {startGame() }
                            .fontWeight(.medium)
                            .font(.title2)
                            .foregroundStyle(.secondary)
                            .border(Color.secondary, width: 0.5)
                    }
                }
            }
        }
        func addNewWord() {
            let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
            guard answer.count > 3 else { return }
            
            guard isIdentical(word: answer) else {
                wordError(title: "Original word recognized", message: "You can't use the same word!")
                return
            }
            
            guard isOriginal(word: answer) else {
                wordError(title: "Word used already", message: "Be more original!")
                return
            }
            
            guard isPossible(word: answer) else {
                wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
                return
            }
            
            guard isReal(word: answer) else {
                wordError(title: "Word not recognized", message: "Don't make up words!")
                return
            }
            withAnimation {
                usedWords.insert(answer, at: 0)
            }
            newWord = ""
            
            if answer.count >= 5 {
                userScore += 2
            } else {
                userScore += 1
            }
            
            if usedWords.count >= 4 {
                userScore += 3
            }
        }
    func startGame() {
        userScore = 0
        usedWords = [String]()
        if let startWordsURL = Bundle.main.url(forResource: "Start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        fatalError("Could not load start.txt from bundle.")
    }
    func isOriginal(word:String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word:String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word:String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func isIdentical(word:String) -> Bool {
        !word.contains(rootWord)
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}
