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
    
    @State var userPoints = 0
    @State var computerPoints = 0
    
    @State var CPUChoice = ["rock", "paper", "scissors"]
    @State var userChoice = ["rock", "paper", "scissors"]
    
    @State var cpuPick = 0
    @State var userPick = 5
    
    @State var results = ["Click to Start","You Win!", "Computer Wins!", "Its a Draw!"]
    @State var resultCount = 0
    
    @State var rColor = 0
    @State var pColor = 0
    @State var sColor = 0
    @State var cColor = 0
    
    @State var colorArray : [Color] = [Color.black, Color.red,Color.green, Color.yellow]
    
    let backgroundGradient = LinearGradient(
        colors: [Color.B1, Color.Orangish],
        startPoint: .top, endPoint: .bottom)
    var body: some View {
        ZStack{
            
            backgroundGradient
            VStack{
                VStack{
                    Text("Rock Paper Scissors!").font(Font.system(size: 28, weight: .bold)).foregroundColor(Color.black) .padding([.top], 80)
                    HStack{
                        Text("Your Score = \(userPoints)            ").font(Font.system(size: 18, weight: .bold)).foregroundColor(.G3)
                        Text("CPU Score = \(computerPoints)").font(Font.system(size: 18, weight: .bold)).foregroundColor(.G3)
                    }.padding()
                    
                    Text("CPU").font(Font.system(size: 24, weight: .heavy)).foregroundColor(.G3)
                    Image(CPUChoice[cpuPick]).resizable()
                        .frame(width: 100, height: 100)
                        .aspectRatio(contentMode: .fit).border(colorArray[cColor], width: 4)
                HStack{
                    Button(action: {
                        userPick = 0
                        rColor = 3
                        pColor = 0
                        sColor = 0
                    }){
                        Image("rock").resizable()
                            .frame(width: 100, height: 100)
                            .aspectRatio(contentMode: .fit).border(colorArray[rColor], width: 4)
                    }
                    
                    Button(action: {
                        userPick = 1
                        pColor = 3
                        rColor = 0
                        sColor = 0
                    }){
                        Image("paper").resizable()
                            .frame(width: 100, height: 100)
                            .aspectRatio(contentMode: .fit).border(colorArray[pColor], width: 4)
                    }
                    
                    Button(action: {
                        userPick = 2
                        sColor = 3
                        pColor = 0
                        rColor = 0
                    }){
                        Image("scissors").resizable()
                            .frame(width: 100, height: 100)
                            .aspectRatio(contentMode: .fit).border(colorArray[sColor], width: 4)
                    }
                    
                    
                }.padding()
                    VStack{
                        Text("Results:").font(Font.system(size: 16, weight: .bold)).foregroundColor(.G3)
                        Text(results[resultCount]).font(Font.system(size: 20, weight: .bold)).foregroundColor(Color.white)
                    }
                Button(action:{
                    cpuPick = Int.random(in: 0..<3)
                    if cpuPick == userPick {
                        resultCount = 3
                        cColor = 0
                        rColor = 0
                        pColor = 0
                        sColor = 0
                    } else if cpuPick == 0{
                        if userPick == 1{
                            userPoints += 1
                            resultCount = 1
                            cColor = 1
                            rColor = 2
                            pColor = 2
                            sColor = 2
                        } else {
                            computerPoints += 1
                            resultCount = 2
                            cColor = 2
                            rColor = 1
                            pColor = 1
                            sColor = 1
                        }
                    } else if cpuPick == 1{
                        if userPick == 2{
                            userPoints += 1
                            resultCount = 1
                            cColor = 1
                            rColor = 2
                            pColor = 2
                            sColor = 2
                        } else {
                            computerPoints += 1
                            resultCount = 2
                            cColor = 2
                            rColor = 1
                            pColor = 1
                            sColor = 1
                        }
                    }else {
                        if userPick == 0{
                            userPoints += 1
                            resultCount = 1
                            cColor = 1
                            rColor = 2
                            pColor = 2
                            sColor = 2
                        } else {
                            computerPoints += 1
                            resultCount = 2
                            cColor = 2
                            rColor = 1
                            pColor = 1
                            sColor = 1
                        }
                    }
                    
                }){
                    Text("Play").font(Font.system(size: 20, weight: .bold)).foregroundColor(.G3).padding().background(Color.B1).clipShape(Capsule())
                }
                }.padding()
            
                
                
                
                if finish {
                    Text("Results are ready:").font(Font.system(size: 20, weight: .bold)).foregroundColor(.G3)
                    Button(action: {
                        toView.toggle()
                    }) {
                        
                        Text("To Results").font(Font.system(size: 20, weight: .bold)).foregroundColor(.G3).padding().background(Color.black).clipShape(Capsule())
                        
                    }
                }else{
                    Text("Results are loading...").font(Font.system(size: 20, weight: .bold)).foregroundColor(.G3).padding().padding()
                }
                
                
                
                
            }.ignoresSafeArea()
        }.ignoresSafeArea()
    }
}

struct Loading_Screen_Previews: PreviewProvider {
    static var previews: some View {
        Loading_Screen(toView: .constant(true), finish: .constant(true))
    }
}





//@State var isFlipping = false
//@State var isHeads = false
//@State var degreesToFlip: Int = 0
//@State var tailsCount: Int = 0
//@State var headsCount: Int = 0


//                VStack {
//
//                    HStack{
//                        ZStack{
//                            Circle()
//                                .foregroundColor(.gray)
//                                .frame (width: 10, height: 10)
//                            Circle()
//                                .foregroundColor(.green)
//                                .frame (width: 9, height: 9)
//                        }
//                        Text("Heads: \(headsCount)")
//                    }
//                    HStack{
//                        ZStack{
//                            Circle()
//                                .foregroundColor(.orange)
//                                .frame (width: 10, height: 10)
//                            Circle()
//                                .foregroundColor(.yellow)
//                                .frame (width: 9, height: 9)
//                        }
//                        Text("Tails: \(tailsCount)")
//                    }
//                }.padding()
//                Coin(isFlipping: $isFlipping, isHeads: $isHeads)
//                    .rotation3DEffect(Angle(degrees: Double(degreesToFlip)), axis: (x: CGFloat(0), y: CGFloat(10), z: CGFloat(0))).padding()
//                Button("Flip Coin") {
//                    flipCoin()
//                }.clipShape(Capsule()).background(Color.black).padding().padding().padding()


//    func flipCoin() {
 //        withAnimation{
 //            let randomNumber = Int.random(in : 5...6)
 //            if degreesToFlip > 1800000000{
 //                reset()
 //            }
 //            degreesToFlip = degreesToFlip + (randomNumber * 180)
 //            headsOrTails()
 //            isFlipping.toggle()
 //        }
 //
 //    }
 //    func headsOrTails () {
 //        let divisible = degreesToFlip / 180
 //        (divisible % 2) == 0 ? (isHeads = false) : (isHeads = true)
 //        isHeads == true ? (headsCount += 1) : (tailsCount += 1)
 //    }
 //    func reset () {
 //        degreesToFlip = 0
 //    }
 //}
 //
 //    struct Coin: View {
 //        @Binding var isFlipping : Bool
 //        @Binding var isHeads : Bool
 //        var body: some View{
 //        ZStack{
 //            Circle()
 //                .foregroundColor(isHeads ? .gray : .orange)
 //                .frame (width: 100, height: 100)
 //            Circle()
 //                .foregroundColor(isHeads ? .green : .yellow)
 //                .frame (width: 90, height: 90)
 //        }
 //    }
 //}
