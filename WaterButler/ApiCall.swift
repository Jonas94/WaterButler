//
//  ApiCall.swift
//  WaterButler
//
//  Created by Jonas Fredriksson on 2021-05-01.
//

import Foundation

class ApiCall {
    
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
        let url = URL(string: UserDefaults.standard.string(forKey: "piwater_url")!+"/loadCurrentWatering")
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
