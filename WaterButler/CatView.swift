//
//  Cat1View.swift
//  WaterButler
//
//  Created by Jonas Fredriksson on 2021-06-01.
//

import SwiftUI
import Lottie
struct CatView: UIViewRepresentable {
    typealias UIViewType = UIView

    var name: String
    var loopMode: LottieLoopMode = .loop
    let isPaused: Bool
    
    
    var animationView = AnimationView()
    
    func makeUIView(context: UIViewRepresentableContext<CatView>) -> UIView {
        let view = UIView(frame: .zero)
        
        animationView.animation = Animation.named(name)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.play()
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<CatView>) {
        if isPaused {
            context.coordinator.parent.animationView.pause()
            
        }
        else {
            context.coordinator.parent.animationView.play()
            
        }
    }


func makeCoordinator() -> Coordinator {
    Coordinator(self)
}

class Coordinator: NSObject {
    var parent: CatView
    
    init(_ parent: CatView) {
        self.parent = parent
    }
}


struct Cat1View_Previews: PreviewProvider {
    static var previews: some View {
        CatView(name: "cat", isPaused: false)
    }
}
}
