//
//  PlannerView.swift
//  WaterButler
//
//  Created by Jonas Fredriksson on 2021-05-09.
//

import SwiftUI

struct EditScheduledItemView: View {
    @ObservedObject var scheduledItem : ScheduledItem
    
    @State var date = Date()
    @State var editMode :Bool
    @State var sundayEnabled : Bool = false
    let apiCall = ApiCall()
    let days : [String] = ["mon" , "tue" , "wed" , "thu" , "fri" , "sat" , "sun"]
    let translatedDays : [String] = ["Måndag" , "Tisdag" , "Onsdag" , "Torsdag" , "Fredag" , "Lördag" , "Söndag"]
    
    var body: some View {
        
        VStack() {
            DatePicker("",
                       selection: getTime(scheduledItem: scheduledItem),
                       displayedComponents: .hourAndMinute
            )
            .datePickerStyle(WheelDatePickerStyle())
            .labelsHidden()
            .onChange(of: date, perform: { value in
                date = value
            })
            .padding()
            
            HStack{
                
                VStack{
      
                    ForEach(0..<4, id: \.self){ key in
                     
                     Toggle(isOn: Binding<Bool>(get: { scheduledItem.days.contains(days[key]) },
                     
                     set: {
                     
                     if $0 {
                     self.scheduledItem.days.append(days[key])
                     } else {
                     self.scheduledItem.days = self.scheduledItem.days.filter { $0 != days[key] }
                     }
                     })) {
                     Text(translatedDays[key])
                     }
               }}.padding()
            
            VStack{
                ForEach(4..<days.count, id: \.self){ key in
                 
                 Toggle(isOn: Binding<Bool>(get: { scheduledItem.days.contains(days[key]) },
                 
                 set: {
                 
                 if $0 {
                 self.scheduledItem.days.append(days[key])
                 } else {
                 self.scheduledItem.days = self.scheduledItem.days.filter { $0 != days[key] }
                 }
                 })) {
                 Text(translatedDays[key])
                 }
           }
            }.padding()
        }.padding()
        
        HStack {
            Image(systemName: "minus")
            Text("🌵")
            Slider(value: getDuration(scheduledItem: scheduledItem), in: 0...30, step: 1)
                //
                .padding()
                .accentColor(Color.blue)
                .overlay(RoundedRectangle(cornerRadius: 15.0)
                            .stroke(lineWidth: 3.0)
                            .foregroundColor(Color.green))
            Text("💦")
            Image(systemName: "plus")
        }.foregroundColor(Color.green).padding()
        Text("Vattna i \(scheduledItem.duration, specifier: "%.0f") minuter")
    }
    .navigationTitle(editMode ? "Ändra" : "Lägg till")
    .navigationBarTitleDisplayMode(.inline)
    .navigationBarItems(trailing: (
    Button(action: {
    print("button pressed")
    saveData(scheduledItem: scheduledItem)
    
    }) {
    Image(systemName: "checkmark")
    .imageScale(.large)
    }
    ))
}
}

func isEnabled(day : String, scheduledItem : ScheduledItem) -> Binding<Bool> {
    let apiCall = ApiCall()
    
    return Binding<Bool>(
        get: { scheduledItem.days.contains(day) },
        set: { newValue in
            if(newValue) {
                scheduledItem.days.append(day)
            }
            else{
                let indexOfDay = scheduledItem.days.firstIndex(of: day)
                scheduledItem.days.remove(at: indexOfDay!)
            }
            apiCall.saveData(scheduledItem: scheduledItem)
            
        })
    
}



func getTime(scheduledItem: ScheduledItem) -> Binding<Date> {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    return Binding<Date>(
        get: {
            dateFormatter.date(from:scheduledItem.time)!
        },
        set: {newValue in
            scheduledItem.time = dateFormatter.string(from: newValue)
        })
}

func getDuration(scheduledItem: ScheduledItem) -> Binding<Double> {
    
    Binding<Double>(
        get: {
            Double(scheduledItem.duration)
        },
        set: { newValue in
            scheduledItem.duration = newValue
            scheduledItem.objectWillChange.send()
        })
}

func saveData(scheduledItem : ScheduledItem) {
    
    // Prepare URL
    let url = URL(string: UserDefaults.standard.string(forKey: "piwater_url")!+"/saveRecurringWatering")
    guard let requestUrl = url else { fatalError() }
    // Prepare URL Request Object
    var request = URLRequest(url: requestUrl)
    request.httpMethod = "POST"
    
    let postString = "id=\(scheduledItem.id)&days=\(scheduledItem.days.joined(separator: ","))&time=\(scheduledItem.time)&duration=\(Int(scheduledItem.duration))";
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

struct EditScheduledItemView_Previews: PreviewProvider {
    static var previews: some View {
        EditScheduledItemView(scheduledItem: ScheduledItem(id: UUID().uuidString, time: "22:00", duration: 3, days: ["Mån", "Ons", "Tors", "Fre"], active: false), editMode: true)
    }
}
