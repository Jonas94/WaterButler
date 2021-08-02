//
//  CurrentWateringView.swift
//  WaterButler
//
//  Created by Jonas Fredriksson on 2021-06-03.
//

import SwiftUI

struct CurrentWateringView: View {
    @ObservedObject var apiCall = ApiCall()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    
    var body: some View {
        var now = Date()
        
        
        VStack{
            VStack{
                if(apiCall.watering != nil){
                    
                    let watering = apiCall.watering!
                    
                    let stopDateInSeconds = Int(watering.stopDate / 1000)
                    let startDateInSeconds = Int(watering.startDate / 1000)
                    let nowInSeconds = Int(now.timeIntervalSince1970)
                    
                    
                    let startDateAsText = formatter.string(from: Date(timeIntervalSince1970: TimeInterval(startDateInSeconds)))
                    let stopDateAsText = formatter.string(from: Date(timeIntervalSince1970: TimeInterval(stopDateInSeconds)))
                    
                    
                    VStack (alignment: .trailing, spacing: 0, content: {
                                Text("Start: \(startDateAsText)")
                                Text("Stopp: \(stopDateAsText)")            })
                    
                    
                    
                    Text("antal minuter: \(watering.duration)")
                    CountdownView(counter: nowInSeconds - startDateInSeconds, countTo:
                                    stopDateInSeconds-startDateInSeconds)
                        .onReceive(timer) { _ in
                            now = Date()
                        }.padding()
                    
                    Button(action: {
                        apiCall.stopCurrentWatering()
                        apiCall.objectWillChange.send()
                    }, label: {
                        Image(systemName: "stop.circle.fill").foregroundColor(.red).font(.system(size: 100))
                    }).padding()
                }
                else{
                    Text("Ingen pågående vattning hittad!").padding()
                }
            }
            
            Button(action: {
                apiCall.loadCurrentWatering()
                apiCall.objectWillChange.send()
            }, label: {
                Image(systemName: "arrow.triangle.2.circlepath").foregroundColor(Color(red: 0 / 255, green: 0 / 255, blue: 128 / 255)
                ).font(.system(size: 100))
                
            }).padding(.top)
        }.onAppear(perform: {
            apiCall.loadCurrentWatering()
        })
    }
}
private var formatter: DateFormatter = {
    let dateFormatterPrint = DateFormatter()
    dateFormatterPrint.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    return dateFormatterPrint
}()


struct CurrentWateringView_Previews: PreviewProvider {
    
    static var previews: some View {
        CurrentWateringView()
        
    }
}
