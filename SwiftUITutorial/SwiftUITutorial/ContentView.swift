//
//  ContentView.swift
//  SwiftUITutorial
//
//  Created by Marvin on 2022/8/28.
//

import SwiftUI

struct ContentView: View {
  
  @State var inputString = ""
  let colors: [Color] =
      [.red, .orange, .yellow, .green, .blue, .purple]

  var body: some View {
      ZStack {
          ForEach(0..<colors.count) {
              Rectangle()
                  .fill(colors[$0])
                  .frame(width: 100, height: 100)
                  .offset(x: CGFloat($0) * 10.0,
                          y: CGFloat($0) * 10.0)
          }
      }
  }
  
  
//  var body: some View {
    
//    HStack {
//
//      Text(inputString)
//        .bold()
//        .padding()
//      TextField("input some text", text: $inputString)
//        .padding()
//    }
    
//    Button {
//      print("a button was tapped")
//    } label: {
//      Image(systemName: "airplane.departure")
//        .font(.system(size: 50))
//        .foregroundColor(.red)
//        .background {
//          Color.gray
//        }
//    }
//  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
