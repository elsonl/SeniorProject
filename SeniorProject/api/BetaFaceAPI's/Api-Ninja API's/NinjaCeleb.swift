import Foundation

class NinjaCeleb : ObservableObject{
    @Published var responses5 = Response5()
    @Published var netWorth : [Int] = []
    @Published var gender : [String] = []
    @Published var occupation : [String] = []
    @Published var height : [Double] = []
    @Published var birthday : [String] = []
    @Published var age : [Int] = []
    @Published var isAlive : [String] = []
    @Published var cName : [String] = []
    @Published var ninjaBool = false
    
    func getData5(callback: @escaping () -> Void, personName: String) {
        
        let name = "\(personName)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let url = URL(string: "https://api.api-ninjas.com/v1/celebrity?name="+name!) else {
            print("Error creating URL")
            return
        }
        print("URL created")
        
        var request = URLRequest(url: url)
        request.setValue("0z2FUq/Y5SiscZHVgWIaWA==LSvugeqGzQAlcZ8n", forHTTPHeaderField: "X-Api-Key")
        
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data else {
                print("Error downloading data")
                return
            }
//            print(String(data: data, encoding: .utf8)!)
//            print("DATA")
//            print(data)
            print("data downloaded")
            if self.ninjaBool {
                DispatchQueue.main.async {
                    self.netWorth.removeAll()
                    self.gender.removeAll()
                    self.occupation.removeAll()
                    self.height.removeAll()
                    self.birthday.removeAll()
                    self.age.removeAll()
                    self.isAlive.removeAll()
                    print("ALL REMOVEED")
                    self.ninjaBool = false
                }
            }
            if data.count == 2{
                DispatchQueue.main.async {
                    self.responses5 = Response5()
                    self.netWorth.append(-1)
                    self.gender.append("Not Available")
                    self.occupation.append("Not Available")
                    self.height.append(-1.0)
                    self.birthday.append("Not Available")
                    self.age.append(-1)
                    self.isAlive.append(String(" "))

                    callback()
                }
            }
            
            do {
                let responseArray = try JSONDecoder().decode([Response5].self, from: data)
                DispatchQueue.main.async {
                if let response = responseArray.first {
            
                  
                    self.responses5 = response
//                                       print(self.responses5)
                    
                    
                    self.netWorth.append(self.responses5.net_worth ?? -1)
                    self.gender.append(self.responses5.gender ?? "Not Availible")
                    self.occupation.append(contentsOf: self.responses5.occupation ?? ["Not Availible"])
                    self.height.append(self.responses5.height ?? -1.0)
                    self.birthday.append(self.responses5.birthday ?? "Not Availible")
                    self.age.append(self.responses5.age ?? -1)
                    self.isAlive.append(String(self.responses5.is_alive!))
                    
                    callback()
                }
            }
            } catch {
                print("Error with decoder")
               
            }
            
        }.resume()
    }
    
    
    // JSON
    struct Response5 : Codable {
        var name : String?
        var net_worth : Int?
        var gender : String?
        var nationality: String?
        var occupation : [String]?
        var height : Double?
        var birthday : String?
        var age : Int?
        var is_alive : Bool?
    }
}
