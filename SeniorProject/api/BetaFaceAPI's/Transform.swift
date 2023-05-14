import Foundation
import SwiftUI

class Transform: ObservableObject {
    @Published var responses3 = Response3()
    @Published var imageBase64 : String = ""
    @Published var imageBase64Array : [String] = []
    @Published var transformBool : Bool = false

    func getData3(callback: @escaping () -> Void, faceUUID: String) {
//        print(faceUUID + " TRANSFORM UUID")
        guard let url = URL(string: "https://www.betafaceapi.com/api/v2/transform") else {
            print("Error creating URL")
            return
        }
        print("URL created")
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let apiKey = "d45fd466-51e2-4701-8da8-04351c872236"
        
        let requestBody: [String: Any] = [
            "api_key": apiKey,
            "faces_uuids": [faceUUID, faceUUID],
            "action": 0,
             "parameters": ""
            ]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: requestBody) else {
            print("Error creating JSON data")
            return
        }
        
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response3, error) in
            guard let data = data else {
                print("Error downloading data")
                return
            }
            
//            print("Data downloaded")
//            print(data)
            
            let decoder = JSONDecoder()
            
            if let response3 = try? decoder.decode(Response3.self, from: data){
                DispatchQueue.main.async {
                    if self.transformBool {
                        self.imageBase64Array.removeAll()
                        self.transformBool = false
                    }
                    
                    self.responses3 = response3
//                    print(self.responses3)
                    self.imageBase64 = self.responses3.image_base64!
                    self.imageBase64Array.append(self.responses3.image_base64!)
//                    print(faceUUID + " TRANSFORM UUID2")
                    callback()
                }
            } else {
                print("Error with decoder")
            }
        }.resume()
    }
    
}
struct Response3: Codable {
    var transform_uuid : String?
    var image_base64 : String?
}
