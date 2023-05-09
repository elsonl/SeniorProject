import Foundation
import SwiftUI

class BetaFace: ObservableObject {
    @Published var responses = Response()
    @Published var UUUID : String?
    @Published var UUIDArray : [String] = []
    
    
    func getData(callback: @escaping () -> Void,selectedImageURL: URL?) {
        guard let url = URL(string: "https://www.betafaceapi.com/api/v2/media/file") else { 
            print("Error creating URL")
            return
        }
        print("URL created")
    
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let boundary = UUID().uuidString
        let contentType = "multipart/form-data; boundary=\(boundary)"
        request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        
        let apiKey = "d45fd466-51e2-4701-8da8-04351c872236"
        guard let imageData = try? Data(contentsOf: selectedImageURL!) else {
            print("Error converting image data")
            return
        }
        
        request.httpBody = createRequestBody(apiKey: apiKey, imageData: imageData, boundary: boundary)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                print("Error downloading data")
                return
            }
            
            print("Data downloaded")
            print(data)
            
            let decoder = JSONDecoder()
            
            if let response = try? decoder.decode(Response.self, from: data) {
                DispatchQueue.main.async {
                    self.responses = response
                    print(self.responses.media)
                    self.UUUID = self.responses.media?.faces[0].face_uuid
                    self.UUIDArray.append(self.UUUID!)
                    print(self.UUIDArray)
                    callback()
                }
            } else {
                print("Error with decoder")
            }
        }.resume()
    }
    
    private func createRequestBody(apiKey: String, imageData: Data, boundary: String) -> Data {
        var body = Data()
        
        // API key parameter
        let apiKeyString = "--\(boundary)\r\nContent-Disposition: form-data; name=\"api_key\"\r\n\r\n\(apiKey)\r\n"
        if let apiKeyData = apiKeyString.data(using: .utf8) {
            body.append(apiKeyData)
        }
        
        // file parameter
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n".data(using: .utf8)!)
        
        // boundary closing
        let boundaryClosing = "--\(boundary)--\r\n"
        if let boundaryClosingData = boundaryClosing.data(using: .utf8) {
            body.append(boundaryClosingData)
        }
        
        return body
    }
}

// Structs our JSON
struct Response: Codable {
    var media: MediaItem?
}

struct MediaItem: Codable {
    var media_uuid: String?
    var checksum: String? // hash
    var faces: [Face]
}

struct Face: Codable {
    var face_uuid: String?
    var x : Double?
    var y : Double?
    var width : Double?
    var height : Double?
    var angle : Double?
    var detection_score : Double?
    var points : [Point]
    var tags : [Tag]
}
// 122 points
struct Point : Codable {
    var x : Double?
    var y : Double?
    var type : Int?
    var  name : String?
}
// 73 tags
struct Tag : Codable {
    var name : String?
    var value : String?
    var confidence : Double?
}
