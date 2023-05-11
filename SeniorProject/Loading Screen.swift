//
//  Loading Screen.swift
//  SeniorProject
//
//  Created by Elson Lin on 5/10/23.
//

import SwiftUI

struct Loading_Screen: View {
    @Binding var toView : Bool
    @Binding var finish : Bool
    
    @State var isFlipping = false
    @State var isHeads = false
    @State var degreesToFlip: Int = 0
    @State var tailsCount: Int = 0
    @State var headsCount: Int = 0
    
    let backgroundGradient = LinearGradient(
        colors: [Color.G1, Color.G1],
        startPoint: .top, endPoint: .bottom)
    var body: some View {
        ZStack{
            backgroundGradient
            VStack{
                
                VStack {
                    
                    HStack{
                        ZStack{
                            Circle()
                                .foregroundColor(.gray)
                                .frame (width: 10, height: 10)
                            Circle()
                                .foregroundColor(.green)
                                .frame (width: 9, height: 9)
                        }
                        Text("Heads: \(headsCount)")
                    }
                    HStack{
                        ZStack{
                            Circle()
                                .foregroundColor(.orange)
                                .frame (width: 10, height: 10)
                            Circle()
                                .foregroundColor(.yellow)
                                .frame (width: 9, height: 9)
                        }
                        Text("Tails: \(tailsCount)")
                    }
                }.padding()
                Coin(isFlipping: $isFlipping, isHeads: $isHeads)
                    .rotation3DEffect(Angle(degrees: Double(degreesToFlip)), axis: (x: CGFloat(0), y: CGFloat(10), z: CGFloat(0))).padding()
                Button("Flip Coin") {
                    flipCoin()
                }.clipShape(Capsule()).background(Color.black).padding().padding().padding()
                
                
                
               
                
                if finish {
                    Text("Results are ready:").font(Font.system(size: 20, weight: .bold)).foregroundColor(.G3).padding()
                    Button(action: {
                        toView.toggle()
                    }) {
                        
                            Text("To Results").font(Font.system(size: 20, weight: .bold)).foregroundColor(.G3).padding().background(Color.black).clipShape(Capsule())
                        
                    }
                }else{
                    Text("Results are loading").font(Font.system(size: 20, weight: .bold)).foregroundColor(.G3).padding()
                }
                
                
                
                
            }.ignoresSafeArea()
        }.ignoresSafeArea()
    }
    func flipCoin() {
        withAnimation{
            let randomNumber = Int.random(in : 5...6)
            if degreesToFlip > 1800000000{
                reset()
            }
            degreesToFlip = degreesToFlip + (randomNumber * 180)
            headsOrTails()
            isFlipping.toggle()
        }
        
    }
    func headsOrTails () {
        let divisible = degreesToFlip / 180
        (divisible % 2) == 0 ? (isHeads = false) : (isHeads = true)
        isHeads == true ? (headsCount += 1) : (tailsCount += 1)
    }
    func reset () {
        degreesToFlip = 0
    }
}
    
    struct Coin: View {
        @Binding var isFlipping : Bool
        @Binding var isHeads : Bool
        var body: some View{
        ZStack{
            Circle()
                .foregroundColor(isHeads ? .gray : .orange)
                .frame (width: 100, height: 100)
            Circle()
                .foregroundColor(isHeads ? .green : .yellow)
                .frame (width: 90, height: 90)
        }
    }
}

//struct Loading_Screen_Previews: PreviewProvider {
//    static var previews: some View {
//        Loading_Screen(toView: $toView)
//    }
//}
