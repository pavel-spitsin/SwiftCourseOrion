//
//  ContentView.swift
//  Lesson_4(Gradients)
//
//  Created by Pavel Spitcyn on 17.09.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        /*
        Text("Hello, world!")
            .font(.largeTitle)
            .padding()
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [.black, .white]), startPoint: .leading, endPoint: .trailing))
        */
        
        /*
        let colors = Gradient(colors: [.red, .yellow, .green, .blue, .purple])
        let gradient = RadialGradient(gradient: colors, center: .center, startRadius: 50, endRadius: 200)
        return Circle()
            .fill(gradient)
            .frame(width: 400, height: 400, alignment: .center)
        */
        
        
        let colors = Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .red])
        let gradient = AngularGradient(gradient: colors, center: .center)
        return Circle()
            //.fill(gradient)
            .strokeBorder(gradient, lineWidth: 100)
    }
}







struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
