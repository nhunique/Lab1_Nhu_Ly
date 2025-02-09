//
//  ContentView.swift
//  Lab1_Nhu_Ly
//
//  Created by Huynh Yen Nhu Ly on 2025-02-08.
//

import SwiftUI

struct ContentView: View {
    
    @State private var gameStarted: Bool = false
    @State private var attemptCount:Int = 0
    @State private var currentNumber: Int = 2
    @State private var score: Int = 0
    @State private var timeRemaining: Int = 5
    @State private var isGameOver: Bool = false
    @State private var wrongAnswers: Int = 0
    @State private var isAnswerCorrect: Bool? = nil
    
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        
        VStack {
            
            if !gameStarted {
                // Show Start Screen
                VStack {
                    Text("Are you ready?")
                        .font(.pacifico(fontStyle: .title))
                        .foregroundStyle(.gray)
                        .padding()
                    
                    Button(action: startGame) {
                        Text("Start Game")
                            .font(.title2)
                            .padding()
                            .foregroundColor(.white)
                            .background(
                                ZStack {
                                    LinearGradient(gradient: Gradient(colors: [Color.mint, Color(white: 0.8)]), startPoint: .top, endPoint: .bottom)
                                        .cornerRadius(10)
                                }
                            )
                            .shadow(color: .mint, radius: 5, x: 0, y: 3)
                    }
                }
                .transition(.opacity)
            } else {
                // Main Game UI
                
                VStack{
                    Text("\(timeRemaining)")
                        .font(.headline)
                }
                Spacer()
                VStack {
                    Text("\(currentNumber)")
                        .font(.pacifico(fontStyle: .largeTitle))
                        .foregroundStyle(.gray)
                        .padding()
                    Button {
                        checkAnswer(isPrimeChoice: true)
                    } label: {
                        Text("Prime")
                            .font(.pacifico(fontStyle: .title))
                        
                    }
                    Button {
                        checkAnswer(isPrimeChoice: false)
                    } label: {
                        Text("Not Prime")
                            .font(.pacifico(fontStyle: .title))
                        
                    }
                }
                Spacer()
                
                ZStack {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 120, height: 120)
                        .foregroundStyle(.green)
                        .opacity(isAnswerCorrect == true ? 1 : 0)
                    
                    Image(systemName: "x.circle.fill")
                        .resizable()
                        .frame(width: 120, height: 120)
                        .foregroundStyle(.red)
                        .opacity(isAnswerCorrect == false ? 1 : 0)
                }
                .animation(.easeInOut(duration: 0.5), value: isAnswerCorrect)
                
                Spacer()
                VStack(alignment: .leading) {
                    Text("Attempt: \(attemptCount)")
                }
                
                .padding()
                
                .onReceive(timer){ _ in
                    
                    guard gameStarted, attemptCount < 10 else {
                        isGameOver = true
                        return
                    }
                    
                    if timeRemaining > 0 {
                        timeRemaining -= 1
                    }
                    // new number every 5 secs
                    // without a user click, count as a wrong answer
                    if timeRemaining == 0 {
                        attemptCount += 1
                        wrongAnswers += 1
                        print("miss - wrong: \(wrongAnswers)")
                        print("score: \(score)")
                        print("--------------")
                        if attemptCount < 10 {
                            generateNewNumber()
                            timeRemaining = 5
                        } else {
                            isGameOver = true
                        }
                    }
                }
                .alert(isPresented: $isGameOver, content: gameOverDialog)
            }
        }
        .animation(.easeInOut, value: gameStarted)

    }
        
    // ----- Functions Logic ------ //
    
    func startGame() {
        gameStarted = true
        resetGame()
    }
    
    
    // Function to display game over dialog
    func gameOverDialog() -> Alert {
        Alert(
            title: Text("Your score \(score)"),
            message: Text("✅ Correct Answers: \(score)\n❌ Wrong Answers: \(wrongAnswers)"),
            primaryButton: .default(Text("Play Again"), action: resetGame),
            secondaryButton: .destructive(Text("Quit Game"), action: { gameStarted = false })
        )
    }
    
    // Function to generate a new number
    func generateNewNumber() {
        currentNumber = Int.random(in: 2...100)
    }
    
    // Function to check if a number is prime
    func isPrime(_ number: Int) -> Bool {
        guard number > 1 else {return false}
        for i in 2..<number {
            if number % i == 0 {
                print("is prime: \(false)")
                return false
            }
        }
        print("is prime: \(true)")
        return true
    }
    
    // Function to validate the answer
    func checkAnswer(isPrimeChoice: Bool){
        //upate attemptCount
        attemptCount += 1
        
        isPrimeChoice ? print("your choice: true") : print("your choice: false")
        if isPrime(currentNumber) == isPrimeChoice {
            print("checking number \(currentNumber) ...")
            score += 1
            isAnswerCorrect = true
        } else {
            wrongAnswers += 1
            isAnswerCorrect = false
        }
        
        print("wrong: \(wrongAnswers)")
        print("score: \(score)")
        print("--------------")
        
        // Wait 1 second before moving to the nextnumber
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            isAnswerCorrect = nil  // Hide the tick/cross
            if !isGameOver {
                //reset timer
                timeRemaining = 5
                generateNewNumber()
            }
        }
        
    }
    
    func resetGame() {
        print("############-----------------------")
        score = 0
        wrongAnswers = 0
        timeRemaining = 5
        isGameOver = false
        attemptCount = 0
        gameStarted = true
        generateNewNumber()
    }
    
}



#Preview {
    ContentView()
}
