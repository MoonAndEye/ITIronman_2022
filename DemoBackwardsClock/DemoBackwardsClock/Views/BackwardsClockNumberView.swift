//
//  BackwardsClockNumberView.swift
//  DemoBackwardsClock
//
//  Created by cm0679 on 2022/9/2.
//

import SwiftUI

struct ClockNumberView: View {
  
  var hour: Int
  
  var body: some View {
    
    VStack {
      Text("\(hour)")
        .fontWeight(.black)
        .rotationEffect(.radians((Double.pi * 2 / 12 * Double(hour))))
      Spacer()
    }
    .padding()
    .rotationEffect(.radians(Double.pi * 2 / 12 * -Double(hour)))
  }
}

struct BackwardsClockNumberView: View {
  var body: some View {
    ZStack {
      ForEach(1..<13) { i in
        ClockNumberView(hour: i)
      }
    }
  }
}

struct BackwardsClockNumberView_Previews: PreviewProvider {
  static var previews: some View {
    ClockNumberView(hour: 1)
      .previewLayout(.fixed(width: 200, height: 200))
    BackwardsClockNumberView()
      .previewLayout(.fixed(width: 200, height: 200))
  }
}
