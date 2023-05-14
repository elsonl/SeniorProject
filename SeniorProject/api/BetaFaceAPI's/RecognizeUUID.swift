//
//  RecognizeUUID.swift
//  SeniorProject
//
//  Created by Elson Lin on 5/8/23.
//

import Foundation
import SwiftUI
class RecognizeUUID : ObservableObject{
    @Published var responses4 = Response4()
    @Published var match = ""
    @Published var confidence = 0.0
    @Published var confidenceArray: [Double] = []
    @Published var matchArray: [String] = []
    @Published var indicies : Int = 0
    @Published var personIDArray : [String] = []
    func getData(callback: @escaping () -> Void, recognizeUUIDString: String){
//        print(recognizeUUIDString)
        guard let url = URL(string: "https://www.betafaceapi.com/api/v2/recognize?api_key=d45fd466-51e2-4701-8da8-04351c872236&recognize_uuid=\(recognizeUUIDString)") else {
            
            print("error creating url")
            return
            
        }
        
        print("URL created")
        
        URLSession.shared.dataTask(with: url) { (data, response4, erros) in
            guard let data = data else{
                print("error downloading data")
                return
            }
            
            print("Data downloaded")
            
            
            let decoder = JSONDecoder()
            
            if let response4 = try? decoder.decode(Response4.self, from: data) {
                DispatchQueue.main.async{
                    
                    self.responses4 = response4
//                    print(self.responses4.results)
                    self.match = self.responses4.results[0].matches[0].face_uuid!
                    self.confidence = self.responses4.results[0].matches[0].confidence!
                    self.confidenceArray.removeAll()
                    self.matchArray.removeAll()
                    self.personIDArray.removeAll()
                    self.indicies = 0
                    for i in self.responses4.results[0].matches.indices{
                        self.confidenceArray.append(self.responses4.results[0].matches[i].confidence!)
                        self.matchArray.append(self.responses4.results[0].matches[i].face_uuid!)
                        self.personIDArray.append( self.responses4.results[0].matches[i].person_id!)
                        self.indicies += 1
//                        print("ARRAYS")
//                        print(self.confidenceArray)
//                        print(self.matchArray)
//                        print(self.personIDArray)
                    }
                    callback()
                    
                }
                
            }else {
                print("error with decoder")
            }
        }.resume()
    }
    
}

//Structs for our JSON
struct Response4: Codable {
    var results: [Result] = [Result]()
}

struct Result: Codable {
    var face_uuid: String?
    var matches: [Match]
}

struct Match: Codable {
    var face_uuid: String?
    var confidence: Double?
    var is_match: Bool?
    var person_id: String?
}
