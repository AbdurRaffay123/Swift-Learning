//
//  ContentView.swift
//  Raffay-Project
//
//  Created by hst on 29/04/2025.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        ZStack{
            Color(red: 0, green: 0, blue: 0).ignoresSafeArea()
              VStack {
                  Image("natureImg")
                      .resizable().cornerRadius(/*@START_MENU_TOKEN@*/30.0/*@END_MENU_TOKEN@*/)
                      .aspectRatio(contentMode: .fit)
                      .padding(.all)
                      Text("Road with yellow leaves")
                          .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color.yellow)
                        
              }
        }
      
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
