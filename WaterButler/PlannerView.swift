//
//  PlannerView.swift
//  WaterButler
//
//  Created by Jonas Fredriksson on 2021-05-09.
//

import SwiftUI

struct PlannerView: View {
    @State var date = Date()
    @State var isLoading = false;
    @State var sliderValue: Double = 0
    
    var body: some View {
        VStack{
            
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
                    //isLoading = true
                    let dateFormatterPrint = DateFormatter()
                    dateFormatterPrint.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                    
                    let apiCall = ApiCall()
                    apiCall.postEnableWatering(sliderValue: sliderValue, startDate: dateFormatterPrint.string(from: date))
                    
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
    
    struct PlannerView_Previews: PreviewProvider {
        static var previews: some View {
            PlannerView()
        }
    }
