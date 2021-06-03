//
//  ApiCall.swift
//  WaterButler
//
//  Created by Jonas Fredriksson on 2021-05-01.
//

import Foundation

class ApiCall {
    
    func getUserComments(completion:@escaping ([Comments]) -> ()) {
        guard let url = URL(string: "https://raspberrypi.local:8090/enableWatering") else { return }

        
       
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let comments = try! JSONDecoder().decode([Comments].self, from: data!)
            print(comments)
            
            DispatchQueue.main.async {
                completion(comments)
            }
        }
        .resume()
    }
    
    
    func postWatering(minutesToWater: Int) -> Void{
        
        // prepare json data
        let json: [String: Any] = ["minutesToWater": "1"]

        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        // create post request
        let url = URL(string: "https://raspberrypi.local:8090/enableWateringNow")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // insert json data to the request
        request.httpBody = jsonData

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
    
    func saveData(scheduledItem : ScheduledItem) {
        
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
    
}
