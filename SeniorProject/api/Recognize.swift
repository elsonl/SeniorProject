import Foundation
import SwiftUI

class Recognize: ObservableObject {
    @Published var responses2 = Response2()
    
    func getData2(callback: @escaping () -> Void, faceUUID: String) {
        guard let url = URL(string: "https://www.betafaceapi.com/api/v2/recognize") else {
            print("Error creating URL")
            return
        }
        print("URL created")
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let apiKey = "d45fd466-51e2-4701-8da8-04351c872236"
        
        let requestBody: [String: Any] = [
            "api_key": apiKey,
            "faces_uuids": [faceUUID],
            "targets": [
                "all@part01.wikipedia.org",
                "all@part02.wikipedia.org",
                "all@part03.wikipedia.org",
                "all@part04.wikipedia.org",
                "all@part05.wikipedia.org",
                "all@part06.wikipedia.org"
            ]
        ]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: requestBody) else {
            print("Error creating JSON data")
            return
        }
        
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                print("Error downloading data")
                return
            }
            
            print("Data downloaded")
            print(data)
            
            let decoder = JSONDecoder()
            
            if let response2 = try? decoder.decode(Response2.self, from: data){
                DispatchQueue.main.async {
                    self.responses2 = response2
                    print(self.responses2)
                    callback()
                }
            } else {
                print("Error with decoder")
            }
        }.resume()
    }
}
struct Response2: Codable {
    var recognize_uuid: String?
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
