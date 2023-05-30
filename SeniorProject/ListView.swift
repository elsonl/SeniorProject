//
//  ListView.swift
//  SeniorProject
//
//  Created by Elson Lin on 5/12/23.
//

import SwiftUI

struct ListView: View {
    
    @StateObject var ninjaCeleb = NinjaCeleb()
    
    @Binding var netWorthArray : [Int]
    @Binding var genderArray : [String]
    @Binding var occupationArray : [String]
    @Binding var heightArray : [Double]
    @Binding var birthdayArray : [String]
    @Binding var ageArray : [Int]
    @Binding var isAliveArray : [String]
    @Binding var count : Int
    @Binding var personIDArrayThing : [String]
    
    @State var occupationCount : Int = 0
    
    @State var tomHollandOccupation : [String] = ["film_director",
                                                  "actor",
                                                  "screenwriter",
                                                  "television_director",
                                                  "film_producer",
                                                  "television_producer"]
    
    let backgroundGradient = LinearGradient(
        colors: [Color.G1, Color.Orangish],
        startPoint: .bottom, endPoint: .top)
   



   
    var body: some View {
//        NavigationView{
//            ZStack{
//                backgroundGradient
            List{
                
                //Constant for tom holland bc the api is stupid
                if personIDArrayThing[count] == "Tom Holland"{
                    HStack{
                        Text("Name: \(personIDArrayThing[count])")
                            .listRowBackground(Color.clear)
                        Spacer()
                        Link(destination: URL(string: "https://en.wikipedia.org/wiki/\(personIDArrayThing[count].replacingOccurrences(of: " ", with: "_"))")!) {
                            Image(systemName: "link")
                                .frame(width: 32, height: 32)
                                .background(Color.blue)
                                .mask(Circle())
                                .foregroundColor(.white)
                        }
                    }.listRowBackground(Color.clear)

                    Text("Net Worth: $15,000,000")
                        .listRowBackground(Color.clear)
                    Text("Gender: Male")
                        .listRowBackground(Color.clear)
                    Text("Height: Not Availible")
                        .listRowBackground(Color.clear)
                    
                    Text("Birthday: 1996-06-01")
                        .listRowBackground(Color.clear)
                    Text("Age: 26")
                        .listRowBackground(Color.clear)
                    Text("Status: Alive")
                        .listRowBackground(Color.clear)
                } else {
                    
                    // Default
                    
                    // name
                    HStack{
                        Text("Name: \(personIDArrayThing[count])")
                            .listRowBackground(Color.clear)
                        Spacer()
                        Link(destination: URL(string: "https://en.wikipedia.org/wiki/\(personIDArrayThing[count].replacingOccurrences(of: " ", with: "_"))")!) {
                            Image(systemName: "link")
                                .frame(width: 32, height: 32)
                                .background(Color.blue)
                                .mask(Circle())
                                .foregroundColor(.white)
                        }
                    }.listRowBackground(Color.clear)
                    
                    if netWorthArray[count] == -1{
                        Text("Net Worth: Not Available")
                            .listRowBackground(Color.clear)
                    } else {
                        Text("Net Worth: $\(netWorthArray[count])")
                            .listRowBackground(Color.clear)
                    }
                    
                    // Gender
                    Text("Gender: \(genderArray[count].capitalized)")
                        .listRowBackground(Color.clear)
                    
                    // Occupation
//                    HStack{
//                        Text("Occupation: \(occupationArray[occupationCount])")
//                        Text("Occupation: \(occupationArray[count].capitalized)")
//
//
//                        Spacer()
//
//                        Button(action: {
//                            print(count)
////                            print(occupationArray)
//                            if occupationCount > 0{
//                                occupationCount -= 1
//                            } else {
//                                occupationCount = occupationArray.count-1
//                            }
//                        }){
//                            Image(systemName: "chevron.left").foregroundColor(.white)
//                        }
//                        Button(action: {
//                            print(count)
////                            print(occupationArray)
//
//                            if occupationCount < occupationArray.count-1{
//                                print("123")
//                                occupationCount += 1
//                            } else {
//                                occupationCount = 0
//                                print("321")
//                            }
//
//                        }){
//                            Image(systemName: "chevron.right").foregroundColor(.white)
//                        }
//
//                    }.listRowBackground(Color.clear)
                    
                    
                    // height
                    if (heightArray[count] == -1.00){
                        Text("Height: Not Availible")
                            .listRowBackground(Color.clear)
                        
                    } else {
                        Text("Height: \(heightArray[count], specifier: "%.2f")m")
                            .listRowBackground(Color.clear)
                    }
                    
                    // Birthday
                    Text("Birthday: \(birthdayArray[count])")
                        .listRowBackground(Color.clear)
                    
                    // Age
                    if(ageArray[count] == -1){
                        Text("Age: Not Availible")
                            .listRowBackground(Color.clear)
                    } else {
                        Text("Age: \(ageArray[count])")
                            .listRowBackground(Color.clear)
                    }
                
                    // Alivability
                    if (isAliveArray[count] == " " || isAliveArray[count] == "nil"){
                        Text("Status: Not Availible")
                            .listRowBackground(Color.clear)
                    } else if isAliveArray[count] == "true"{
                        Text("Status: Alive")
                            .listRowBackground(Color.clear)
                    } else {
                        Text("Status: Dead")
                            .listRowBackground(Color.clear)
                    }
                
                       
                }
                
            }.background(.clear)
        
            .scrollContentBackground(.hidden)
        

            
//        }
        
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(
            netWorthArray: .constant([00000000]),
            genderArray: .constant(["Gender"]),
            occupationArray: .constant(["occupation"]),
            heightArray: .constant([00.000000]),
            birthdayArray: .constant(["Birthday"]),
            ageArray: .constant([00000000]),
            isAliveArray: .constant([" "]), count: .constant(0), personIDArrayThing: .constant(["name"])
        )
    }
}
