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
                    
                    PlannerView()
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

