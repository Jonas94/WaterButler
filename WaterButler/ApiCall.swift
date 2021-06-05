//
//  ApiCall.swift
//  WaterButler
//
//  Created by Jonas Fredriksson on 2021-05-01.
//

import Foundation

class ApiCall :ObservableObject{

    @Published var watering : Watering1? = nil
    
    func postEnableWatering(sliderValue: Double, startDate: String){
        let bodyData = "minutesToWater=\(Int(sliderValue))&startDate=\(startDate)"
        // create post request
        let url = URL(string: UserDefaults.standard.string(forKey: "piwater_url")!+"/enableWatering")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = bodyData.data(using: .utf8)
        
        print(request)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }
        
        task.resume()
    }
    
    func saveScheduledItem(scheduledItem : ScheduledItem) {
        
        // Prepare URL
        let url = URL(string: UserDefaults.standard.string(forKey: "piwater_url")!+"/saveRecurringWatering")
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
        
        let url = URL(string: UserDefaults.standard.string(forKey: "piwater_url")!+"/getCurrentWatering")
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
    
    
    
    
}
