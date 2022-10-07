//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Romy Shvagir
//

import SwiftUI

struct ButtonStyleWhiteBlue: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(30)
            .background(Circle().fill(.white))
            .shadow(color: Color(#colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)), radius: 40, x: 5, y: 5)
            .font(.largeTitle)
    }
}

extension View {
    func toWhiteBlue() -> some View {
        self.modifier(ButtonStyleWhiteBlue())
    }
}

struct ContentView: View {
    @State private var badges = ["🪨", "✂️", "📄"].shuffled()
    @State private var compChoise: Int = Int.random(in: 0..<3)
    @State private var winOrLose: Bool = Bool.random()
    @State private var score: Int = 0
    @State private var showAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var totalScore: Int = 0
    @State private var gameOver: Bool = false
   
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.004859850742, green: 0.09608627111, blue: 0.5749928951, alpha: 1))
            VStack {
                Spacer()
                Text(badges[compChoise])
                    .toWhiteBlue()
                Text("Make a move to " + winOnLoseChoise().uppercased())
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding(.vertical, 50)
                
                HStack(spacing: 40) {
                    ForEach(badges, id:\.self) { image in
                        Button {
                            countMoveResult(image)
                            showAlert.toggle()
                            totalScore += 1
                        } label: {
                            Text(image)
                                .toWhiteBlue()
                        }
                    }
                }
                .alert(alertTitle, isPresented: $showAlert) {
                    Button {
                        shuffleAll()
                    } label: {
                        Text("OK")
                    }

                }
                .alert("Game over", isPresented: $gameOver) {
                    Button("OK", action: resetGame)
                } message: {
                        Text("Game over! Play again 😎")
                    }
                Spacer()
                Text("Your score is \(score)")
                    .foregroundColor(Color(#colorLiteral(red: 0.7985997796, green: 0.2384213209, blue: 0.25352633, alpha: 1)))
                    .bold()
                    .font(.headline)
                    .padding()
                    .background(.white)
                    .cornerRadius(15)
                    .shadow(color: Color(#colorLiteral(red: 0.003998827189, green: 0.04991490394, blue: 0.2995548248, alpha: 1)), radius: 10, x: 2, y: 2)
                    .padding(.bottom, 50)
            }
        }
        .ignoresSafeArea()
    }

    func countMoveResult(_ image: String) {
        let compArray = ["🪨", "📄", "✂️"]
        let winArray = ["📄", "✂️", "🪨"]
        let loseArray = ["✂️", "🪨", "📄"]
        if (compArray.firstIndex(of: badges[compChoise]) == winArray.firstIndex(of: image) && winOrLose) || (compArray.firstIndex(of: badges[compChoise]) == loseArray.firstIndex(of: image) && !winOrLose) {
                score += 1
                alertTitle = "You win! Your score is \(score)"
        } else {
            score -= 1
            alertTitle = "You lose! Your score is \(score)"
        }
        if totalScore == 9 {
            gameOver.toggle()
        }
    }
    func winOnLoseChoise() -> String {
        winOrLose ? "win" : "lose"
    }
    func shuffleAll() {
        badges.shuffle()
        compChoise = Int.random(in: 0..<3)
        winOrLose = Bool.random()
        
    }
    func resetGame() {
        (score, totalScore) = (0, 0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
