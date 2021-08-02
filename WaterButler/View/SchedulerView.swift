//
//  SchedulerView.swift
//  WaterButler
//
//  Created by Jonas Fredriksson on 2021-05-31.
//

import SwiftUI

struct SchedulerView: View {
    
    @ObservedObject private var schedulerViewModel = SchedulerViewModel(loading: true)

    var body: some View {
        VStack{
            if(schedulerViewModel.loading){
            CatView(name: "cat", isPaused: !schedulerViewModel.loading)
            }
            List{
                ForEach(schedulerViewModel.scheduledItems){ item in
                    NavigationLink(
                        destination: EditScheduledItemView(scheduledItem: ScheduledItem(id: item.id, time: item.time, duration: item.duration, days: item.days, active: item.active), editMode: true),
                        label: {
                            ScheduledItemView(scheduledItem: ScheduledItem(id: item.id, time: item.time, duration: item.duration, days: item.days, active: item.active))
                        })
                }.onDelete(perform: schedulerViewModel.deleteItem)
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
                }.onAppear{
                    schedulerViewModel.loadScheduledItems()
                    
                }
                }
    }

    
    private var formatter: DateFormatter = {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dateFormatterPrint
    }()

    
    struct SchedulerView_Previews: PreviewProvider {
        static var previews: some View {
            
            let items : [ScheduledItem] = [ScheduledItem(id: UUID().uuidString, time: "22:00", duration: 3, days: ["Mån", "Tis", "Ons", "Tors", "Fre"], active: false),
                                           ScheduledItem(id: UUID().uuidString, time: "12:00", duration: 5, days: ["Lör", "Sön"], active: true)]
            SchedulerView()
        }
    }
}
