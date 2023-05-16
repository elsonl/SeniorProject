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
    @Binding var isAliveArray : [Bool]
    @Binding var count : Int
    @Binding var personIDArrayThing : [String]
    
    var body: some View {
        NavigationView{
            List{
                Text("Name: \(personIDArrayThing[count])")
                Text("Net Worth: $\(netWorthArray[count])")
                Text("Gender: \(genderArray[count])")
                Text("Occupation: \(occupationArray[count])")
                Text("Height: \(heightArray[count], specifier: "%.2f")m")
               
                Text("Birthday: \(birthdayArray[count])")
                Text("Age: \(ageArray[count])")
                Text("Is Alive: \(String(describing: isAliveArray[count]))")
                
            }
        }
        
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
            isAliveArray: .constant([true]), count: .constant(0), personIDArrayThing: .constant(["name"])
        )
    }
}
