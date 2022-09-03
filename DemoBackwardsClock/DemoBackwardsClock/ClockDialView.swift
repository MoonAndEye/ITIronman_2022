//
//  ClockDialView.swift
//  DemoBackwardsClock
//
//  Created by cm0679 on 2022/9/2.
//

import SwiftUI

struct ClockDialView: View {
  var body: some View {
    
    ZStack {
      Circle()
        .stroke()
        .padding(3)
      HStack {
        Spacer()
        BackwardsClockNumberView()
        Spacer()
      }
    }
  }
}

struct ClockDialView_Previews: PreviewProvider {
  static var previews: some View {
    ClockDialView()
      .frame(width: 200, height: 200, alignment: .center)
  }
}
