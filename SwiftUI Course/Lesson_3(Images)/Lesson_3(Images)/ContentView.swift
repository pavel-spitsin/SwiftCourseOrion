//
//  ContentView.swift
//  Lesson_3(Images)
//
//  Created by Pavel Spitcyn on 17.09.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        /*
        Image("apple")
            .resizable()
            .aspectRatio(contentMode: .fit)
        */
        
        /*
        Image(systemName: "cloud.sun.fill")
            .font(.largeTitle)
            .padding(30)
            .background(Color.green)
            .foregroundColor(.blue)
            //.clipShape(Circle())
            //.clipShape(RoundedRectangle(cornerRadius: 30))
            .clipShape(Capsule())
 */
        
        /*
        Text("Hello, Apple")
            .background(
                Image("apple")
                    .resizable()
                    .frame(width: 300, height: 300, alignment: .center)
            )
        */
        
        Text("Hello, Apple")
            .background(
                Circle()
                    .fill(Color.red)
                    .frame(width: 300, height: 300, alignment: .center)
            )
        
    }
}










struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
