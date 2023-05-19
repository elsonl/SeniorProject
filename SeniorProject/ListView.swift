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
    
    @State var tomHollandOccupation : [String] = ["film_director",
                                                  "actor",
                                                  "screenwriter",
                                                  "television_director",
                                                  "film_producer",
                                                  "television_producer"]
    
    let backgroundGradient = LinearGradient(
        colors: [Color.B1, Color.Orangish],
        startPoint: .top, endPoint: .bottom)

   
    var body: some View {
//        NavigationView{
//            ZStack{
//                backgroundGradient
            List{
                if personIDArrayThing[count] == "Tom Holland"{
                    Text("Name: \(personIDArrayThing[count])")
                        .listRowBackground(Color.G3)

                    Text("Net Worth: $15,000,000")
                        .listRowBackground(Color.G3)
                    Text("Gender: Male")
                        .listRowBackground(Color.G3)
                    Text("Occupation: \(tomHollandOccupation[count].capitalized)")
                        .listRowBackground(Color.G3)
                    Text("Height: Not Availible")
                        .listRowBackground(Color.G3)
                    
                    Text("Birthday: 1996-06-01")
                        .listRowBackground(Color.G3)
                    Text("Age: 26")
                        .listRowBackground(Color.G3)
                    Text("Status: Alive")
                        .listRowBackground(Color.G3)
                } else {
                    Text("Name: \(personIDArrayThing[count])")
                        .listRowBackground(Color.G3)
                    
                    if netWorthArray[count] == -1{
                        Text("Net Worth: Not Available")
                            .listRowBackground(Color.G3)
                    } else {
                        Text("Net Worth: $\(netWorthArray[count])")
                            .listRowBackground(Color.G3)
                    }
                    Text("Gender: \(genderArray[count].capitalized)")
                        .listRowBackground(Color.G3)
                    Text("Occupation: \(occupationArray[count].capitalized)")
                        .listRowBackground(Color.G3)
                    if (heightArray[count] == -1.00){
                        Text("Height: Not Availible")
                            .listRowBackground(Color.G3)
                        
                    } else {
                        Text("Height: \(heightArray[count], specifier: "%.2f")m")
                            .listRowBackground(Color.G3)
                    }
                    
                    Text("Birthday: \(birthdayArray[count])")
                        .listRowBackground(Color.G3)
                    if(ageArray[count] == -1){
                        Text("Age: Not Availible")
                            .listRowBackground(Color.G3)
                    } else {
                        Text("Age: \(ageArray[count])")
                            .listRowBackground(Color.G3)
                    }
                    if (isAliveArray[count] == " " || isAliveArray[count] == "nil"){
                        Text("Status: Not Availible")
                            .listRowBackground(Color.G3)
                    } else if isAliveArray[count] == "true"{
                        Text("Status: Alive")
                            .listRowBackground(Color.G3)
                    } else {
                        Text("Status: Dead")
                            .listRowBackground(Color.G3)
                    }
                }
                
            }.background( backgroundGradient).ignoresSafeArea().scrollContentBackground(.hidden)


            
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
