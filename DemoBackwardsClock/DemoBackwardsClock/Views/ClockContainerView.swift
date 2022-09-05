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
  
  @State var hourDegree: Double = 0
  @State var minuteDegree: Double = 0
  @State var secondDegree: Double = 0
  
  private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
  
  private let angleUtility: AngleUtility = .init()
  
  var body: some View {
    ZStack {
      ClockDialView()
      HandShape(handLength: .hour)
        .fill(Color.blue)
        .rotationEffect(Angle(degrees: hourDegree))
      HandShape(handLength: .minute)
        .fill(Color.cyan)
        .rotationEffect(Angle(degrees: minuteDegree))
      HandShape(handLength: .second)
        .fill(Color.red)
        .rotationEffect(Angle(degrees: secondDegree))
      Circle()
        .fill(Color.orange)
        .frame(width: 20, height: 20, alignment: .center)
    }
    .frame(width: width, height: height, alignment: .center)
    .onReceive(timer) { _ in
      updateTime()
    }
  }
  
  private func updateTime() {
    let timestamp = Date().timeIntervalSince1970
    
    secondDegree = angleUtility.getBackwardsSecondHandRadius(from: timestamp)
    minuteDegree = angleUtility.getBackwardsMinuteHandRadius(from: timestamp)
    hourDegree = angleUtility.getBackwardsHourHandRadius(from: timestamp)
  }
}

struct ClockContainerView_Previews: PreviewProvider {
  static var previews: some View {
    ClockContainerView()
  }
}
