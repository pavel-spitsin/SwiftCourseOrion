//
//  ContentView.swift
//  Lesson_1(VStack, HStack, ZStack)
//
//  Created by Pavel Spitcyn on 17.09.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        /*
        VStack(alignment: .center, spacing: 100) {
            //Spacer()
            Text("Hello, world!")
            //Divider()
                //.padding(.init(top: 0, leading: 0, bottom: 50, trailing: 0))
                .padding(.vertical, 50)
            Spacer()
                .frame(height: 3)
            Text("Hello")
            //Spacer()
        }
        */
        
        ZStack {
            Image("apple")
            Text("Hello, Apple!")
                .font(.largeTitle)
                .background(Color.blue)
                .foregroundColor(.white)
        }
    }
}








struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
