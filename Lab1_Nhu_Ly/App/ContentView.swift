//
//  ContentView.swift
//  Lab1_Nhu_Ly
//
//  Created by Huynh Yen Nhu Ly on 2025-02-08.
//

import SwiftUI

struct ContentView: View {
        
    @State var count = 0
    @State var clock = "00:00"
    
    @State private var currentNumber: Int = 2
    @State private var score: Int = 0
    @State private var timeRemaining = 10
    @State private var isGameOver = false
    @State private var wrongAnswers: Int = 0
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    
    var body: some View {
        
        VStack {
            VStack{
                Text("\(clock)")
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
                Text("\(count)")
            }
        }
        .padding()
    }
    
    // ----- Functions Logic ------ //
    
    // Function to generate a new number
    func generateNewNumber() {
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
        }
        print("score: \(score)")
        print("--------------")
        generateNewNumber()
    }
    
}

#Preview {
    ContentView()
}
