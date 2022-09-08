//
//  ClockDialView.swift
//  DemoBackwardsClock
//
//  Created by cm0679 on 2022/9/2.
//

import SwiftUI

struct ClockDialView: View {
  
  @Binding var dialColor: Color
  
  var tickLength: CGFloat = 5
  
  var body: some View {
    
    ZStack {
      /// 真的會變色的部分
      Circle()
        .fill(dialColor)
        .padding(3)
      /// 外框
      Circle()
        .stroke()
        .padding(3)
      
      ticks
        .padding(3)
      
      HStack {
        Spacer()
        BackwardsClockNumberView()
        Spacer()
      }
    }
  }
  
  private func isLongTick(_ position: Int) -> Bool {
    return position % 5 == 0
  }
 
  var ticks: some View {

    ForEach(0..<60) { position in
      let longerTick = tickLength * 1.8

      Tick(tickLength: isLongTick(position) ? longerTick : tickLength )
        .stroke(lineWidth: 3)
        .rotationEffect(.radians(Double.pi * 2 / 60 * Double(position)))
    }
  }
}

struct ClockDialView_Previews: PreviewProvider {
  
  @State static var dialColor: Color = .green
  
  static var previews: some View {
    ClockDialView(dialColor: $dialColor, tickLength: 5)
      .frame(width: 200, height: 200, alignment: .center)
  }
}
