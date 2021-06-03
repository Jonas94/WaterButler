//
//  Cat1View.swift
//  WaterButler
//
//  Created by Jonas Fredriksson on 2021-06-01.
//

import SwiftUI
import Lottie
struct CatView: UIViewRepresentable {
    var name: String
    var loading : Bool
    var loopMode: LottieLoopMode = .loop
    
    
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
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<CatView>) {}
}

struct Cat1View_Previews: PreviewProvider {
    static var previews: some View {
        CatView(name: "cat", loading: true)
    }
}
