//
//  ApiCall.swift
//  WaterButler
//
//  Created by Jonas Fredriksson on 2021-05-01.
//

import Foundation

class ApiCall :ObservableObject{

    @Published var watering : Watering1? = nil
    @Published var enabledWateringResponse : String?

    
    func postEnableWatering(sliderValue: Double, startDate: String){
        let bodyData = "minutesToWater=\(Int(sliderValue))&startDate=\(startDate)"
        // create post request
        let url = getUrl(endpoint: "enableWatering")
        guard let requestUrl = url else { fatalError() }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        request.httpBody = bodyData.data(using: .utf8)
        
        print(request)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: String] {
                print(responseJSON)
                self.enabledWateringResponse = responseJSON["message"]
                print(self.enabledWateringResponse)

            }
        }
        
        task.resume()
    }
    
    func saveScheduledItem(scheduledItem : ScheduledItem) {
        
        // Prepare URL
        let url = getUrl(endpoint: "saveRecurringWatering")
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        let postString = "id=\(scheduledItem.id)&days=\(scheduledItem.days.joined(separator: ","))&time=\(scheduledItem.time)&duration=\(Int(scheduledItem.duration))&active=\(scheduledItem.active)";
        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Check for Error
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            // Convert HTTP Response Data to a String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
            }
        }
        task.resume()
    }
    
    func loadCurrentWatering() {
        // Prepare URL
        //var watering : Watering
        
        let url = getUrl(endpoint: "getCurrentWatering")
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Check for Error
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            // Convert HTTP Response Data to a String
             if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")

                if let response = try? JSONDecoder().decode(Watering1.self, from: data) {
                    DispatchQueue.main.async {
                        print(response)
                        self.watering = response
                    }
                    if let error = error {
                        print("Error took place \(error)")
                        return
                    }
            }
        }
    }
        task.resume()
    }
    
    func stopCurrentWatering() {
        
        let url = getUrl(endpoint: "stop")
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Check for Error
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            // Convert HTTP Response Data to a String
             if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")

                if let response = try? JSONDecoder().decode(Watering1.self, from: data) {
                    DispatchQueue.main.async {
                        print(response)
                    }
                    if let error = error {
                        print("Error took place \(error)")
                        return
                    }
            }
        }
    }
        task.resume()
    }
    
    
    func getUrl(endpoint: String) -> URL? {
    var urlString : String
    if UserDefaults.standard.string(forKey: "piwater_url") == nil
    {
        urlString = "localhost:8090"
        print("userdefaults is nil")
        
    }
    else {
        urlString = UserDefaults.standard.string(forKey: "piwater_url")!
    }

        return URL(string: "\(urlString)/\(endpoint)")
      
    }
}
