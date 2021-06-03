//
//  ContentView.swift
//  WaterButler
//
//  Created by Jonas Fredriksson on 2021-04-30.
//

import SwiftUI

struct ContentView: View {
    @State var showMenu = false
    
    var body: some View {
        
        let drag = DragGesture().onEnded{
            if $0.translation.width < -100 {
                withAnimation{
                    self.showMenu = false
                }
            }
        }

        
        return NavigationView{
            GeometryReader {geometry in
                ZStack(alignment: .leading){
                    
                    MainView(showMenu: self.$showMenu)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .offset(x: self.showMenu ? geometry.size.width/2: 0)
                        .disabled(self.showMenu ? true : false)
                    if self.showMenu{
                        MenuView()
                            .frame(width: geometry.size.width/2)
                            .transition(.move(edge: .leading))
                    }
                }.gesture(drag)
            }.navigationBarTitle("Manuell vattning", displayMode: .inline)
            .navigationBarItems(leading: (
                Button(action: {
                    withAnimation{
                        self.showMenu.toggle()
                    }
                }) {
                    Image(systemName: "line.horizontal.3")
                        .imageScale(.large)
                }
            ))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct MainView: View {
    @Binding var showMenu: Bool
    @State var date = Date()
    @State var isLoading = false;
    @State var sliderValue: Double = 0
    let stanDefaults = UserDefaults.standard

    var body: some View {
        VStack{
           // Text(stanDefaults.string(forKey: "piwater_url")!)
            VStack {
                DatePicker("",
                           selection: $date,
                           in: Date()...)
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
                    .onChange(of: date, perform: { value in
                        date = value
                        print(date)
                    })
                    .padding(100)
            
                
                if(isLoading){
                    
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                            .scaleEffect(5)
                        Spacer()
                    }
                    //.padding(.top, 10)
                    
                
                HStack {
                    Image(systemName: "minus")
                    Text("🌵")
                    Slider(value: $sliderValue, in: 0...30, step: 1)
                        .padding()
                        .accentColor(Color.blue)
                        .overlay(RoundedRectangle(cornerRadius: 15.0)
                                    .stroke(lineWidth: 3.0)
                                    .foregroundColor(Color.green))
                    Text("💦")
                    Image(systemName: "plus")
                }.foregroundColor(Color.green)
                Text("Vattna i \(sliderValue, specifier: "%.0f") minuter")
                
                Button(action: {
                    print("Button action")
                    //apiCall().getUserComments { (comments) in
                    //   self.comments = comments
                    // }
                    isLoading = true
                    let dateFormatterPrint = DateFormatter()
                    dateFormatterPrint.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                    
                    let bodyData = "minutesToWater=\(Int(sliderValue))&startDate=\(dateFormatterPrint.string(from: date))"
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
                            isLoading = false
                            
                        }
                    }
                    
                    task.resume()
                    
                    
                }) {
                    HStack {
                        Text("Vattna 💦")
                            .padding()
                    }
                }
            }
            
        }
    }
}
