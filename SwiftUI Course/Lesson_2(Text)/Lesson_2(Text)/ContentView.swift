//
//  ContentView.swift
//  Lesson_2(Text)
//
//  Created by Pavel Spitcyn on 17.09.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        /*
         Text("Let's style our text views with fonts, colors and line spacing")
         .tracking(5)//не добавляет дополнительный пробел в конце, в отличие от kerning
         //.kerning(5)
         .lineLimit(nil)
         .truncationMode(.middle)
         .font(.largeTitle)
         .multilineTextAlignment(.center)
         .background(Color.init(#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)))
         .foregroundColor(.blue)
         .lineSpacing(50)
         */
        
        Text("Hello, World!")
            /*
             .font(.largeTitle)
             .padding()
             .background(Color.yellow)
             .padding()
             .background(Color.red)
             */
            
            .font(.largeTitle)
            .padding()
            .background(Color.yellow)
    }
}







struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
