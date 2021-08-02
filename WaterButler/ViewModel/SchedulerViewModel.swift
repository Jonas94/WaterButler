//
//  SchedulerViewModel.swift
//  WaterButler
//
//  Created by Jonas Fredriksson on 2021-06-12.
//

import Foundation

class SchedulerViewModel : ObservableObject {
    
    @Published var scheduledItems : [ScheduledItem] = []
    @Published var loading : Bool
    
    init(loading: Bool) {
        self.loading = loading
    }

    
    func loadScheduledItems() {
        self.loading = true
            var urlString : String
            if UserDefaults.standard.string(forKey: "piwater_url") == nil
            {
                urlString = "localhost:8090"
                print("userdefaults is nil")
                
            }
            else {
                urlString = UserDefaults.standard.string(forKey: "piwater_url")!
            }
                guard let url = URL(string: "\(urlString)/getAllRecurringWaterings") else {
                print("Your API end point is Invalid")
                return
            }
            let request = URLRequest(url: url)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                
                if let data = data {
                    print("Fetching data...")
                    if let response = try? JSONDecoder().decode([ScheduledItem].self, from: data) {
                        DispatchQueue.main.async {
                            print(response)
                            self.scheduledItems = response
                            self.loading = false

                        }

                        return
                    }
                }

            }.resume()
        }
    
    
    func deleteItem(at indexSet: IndexSet){
        self.scheduledItems.remove(atOffsets: indexSet)
    }
    
    
    
}
