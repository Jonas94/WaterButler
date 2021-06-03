//
//  SchedulerView.swift
//  WaterButler
//
//  Created by Jonas Fredriksson on 2021-05-31.
//

import SwiftUI

struct SchedulerView: View {
    
    @State var items = [ScheduledItem]()
    @State var isWaitingForCall : Bool = true
    
    var body: some View {
        VStack{
            if isWaitingForCall{
                CatView(name: "cat", loading: isWaitingForCall)
            }
            List{
                ForEach(items){ item in
                    NavigationLink(
                        destination: EditScheduledItemView(scheduledItem: ScheduledItem(id: item.id, time: item.time, duration: item.duration, days: item.days, active: item.active), editMode: true),
                        label: {
                            ScheduledItemView(scheduledItem: ScheduledItem(id: item.id, time: item.time, duration: item.duration, days: item.days, active: item.active))
                        })
                }
                .navigationTitle("Schemaläggare")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    NavigationLink(
                        destination: EditScheduledItemView(scheduledItem: ScheduledItem(id: "UUID1", time: "12:00", duration: 0, days: [], active: true), editMode: false),
                        label: {
                            Image(systemName: "plus")
                        }
                    )
                }
            }                .onAppear(perform: loadData)
        }
        
    }
    
    
    func loadData() {
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
                        self.items = response
                    }
                    return
                }
            }
        }.resume()
        isWaitingForCall = false
    }

    
    struct SchedulerView_Previews: PreviewProvider {
        static var previews: some View {
            
            var items : [ScheduledItem] = [ScheduledItem(id: UUID().uuidString, time: "22:00", duration: 3, days: ["Mån", "Tis", "Ons", "Tors", "Fre"], active: false),
                                           ScheduledItem(id: UUID().uuidString, time: "12:00", duration: 5, days: ["Lör", "Sön"], active: true)]
            SchedulerView(items: items, isWaitingForCall:  true)
        }
    }
}
