//
//  ContentView.swift
//  Lab1_Nhu_Ly
//
//  Created by Huynh Yen Nhu Ly on 2025-02-08.
//

import SwiftUI

struct ContentView: View {
        
    @State private var attemptCount = 0
    @State private var currentNumber: Int = 2
    @State private var score: Int = 0
    @State private var timeRemaining = 5
    @State private var isGameOver = false
    @State private var wrongAnswers: Int = 0
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    
    var body: some View {
        
        VStack {
            VStack{
                Text("\(timeRemaining)")
            }
            VStack {
                Text("\(currentNumber)")
                    .font(.pacifico(fontStyle: .largeTitle))
                    .foregroundStyle(.black)
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
            .padding()
            VStack{
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .frame(width: 70, height: 70)    .foregroundStyle(.green)
                Image(systemName: "x.circle")
                    .resizable()
                    .frame(width: 70, height: 70)    .foregroundStyle(.red)
                
            }
            Spacer()
            VStack(alignment: .leading) {
                Text("Attempt: \(attemptCount)")
            }
        }
        .padding()
        .onReceive(timer){ _ in
            guard attemptCount < 10 else {
                isGameOver = true
                return
            }
            
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
            // new number every 5 secs
            // without a user click, count as a wrong answer
            if timeRemaining == 0 {
                wrongAnswers += 1
                generateNewNumber()
                timeRemaining = 5 //reset timer
            }
        }
        .alert("Your Score: \(score)", isPresented: $isGameOver) {
            
            Button("Play Again") {
                resetGame()
            }
        } message: {
            Text("✅ Correct Answers: \(score)\n❌ Wrong Answers: \(wrongAnswers)")
            
        }
    }
        
        
    // ----- Functions Logic ------ //
    
    // Function to display game over dialog
    func gameOverDialog() -> Alert {
        Alert(
            title: Text("Your score \(score)"),
            message: Text("✅ Correct Answers: \(score)\n❌ Wrong Answers: \(wrongAnswers)"),
            dismissButton: .default(Text("Play Again"), action: resetGame)
        )
    }
    
    // Function to generate a new number
    func generateNewNumber() {
        //upate attemptCount
        attemptCount += 1
        currentNumber = Int.random(in: 2...100)
    }
    
    // Function to check if a number is prime
    func isPrime(_ number: Int) -> Bool {
        print("checking number \(number) ...")
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
        isPrimeChoice ? print("your choice: true") : print("your choice: false")
        if isPrime(currentNumber) == isPrimeChoice {
            score += 1
        } else {
            score -= 1
            wrongAnswers += 1
        }
        print("score: \(score)")
        print("--------------")
        
        //reset timer
        if(!isGameOver){
            timeRemaining = 5
            generateNewNumber()
        }
    }
    
    func resetGame() {
        score = 0
        wrongAnswers = 0
        timeRemaining = 10
        isGameOver = false
        attemptCount = 0
        generateNewNumber()
    }
    
}

#Preview {
    ContentView()
}
