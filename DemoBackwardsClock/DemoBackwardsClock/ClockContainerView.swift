//
//  ClockContainerView.swift
//  DemoBackwardsClock
//
//  Created by cm0679 on 2022/8/31.
//

import SwiftUI

struct ClockContainerView: View {
  
  var width: CGFloat = 200
  var height: CGFloat = 200
  
  var body: some View {
    ZStack {
      ClockDialView()
      HandShape(handLength: .hour)
        .fill(Color.blue)
        .rotationEffect(Angle(degrees: 300))
      HandShape(handLength: .minute)
        .fill(Color.cyan)
        .rotationEffect(Angle(degrees: 60))
      HandShape(handLength: .second)
        .fill(Color.red)
        .rotationEffect(Angle(degrees: 180))
    }
    .frame(width: width, height: height, alignment: .center)
  }
}

struct ClockContainerView_Previews: PreviewProvider {
  static var previews: some View {
    ClockContainerView()
  }
}
