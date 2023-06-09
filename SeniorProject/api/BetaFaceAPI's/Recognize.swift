import Foundation
import SwiftUI

class Recognize: ObservableObject {
    @Published var responses2 = Response2()
    @Published var recognizeUUID : String = ""
    
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

                "all@personSeniorProject"
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
//            print(data)
            
            let decoder = JSONDecoder()
            
            if let response2 = try? decoder.decode(Response2.self, from: data){
                DispatchQueue.main.async {
                    self.responses2 = response2
//                    print(self.responses2)
                    self.recognizeUUID = self.responses2.recognize_uuid!
//                    print(self.recognizeUUID + " UUIDDIDID")
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
}
