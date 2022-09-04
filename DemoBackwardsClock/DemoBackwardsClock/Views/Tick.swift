//
//  Tick.swift
//  DemoBackwardsClock
//
//  Created by cm0679 on 2022/9/3.
//

import SwiftUI

struct Tick: Shape {
  
  var tickLength: CGFloat
  
  func path(in rect: CGRect) -> Path {
    
    var p = Path()
    p.move(to: CGPoint(x: rect.midX, y: rect.minY))
    p.addLine(to: CGPoint(x: rect.midX, y: rect.minY + tickLength))
    
    return p
  }
}

struct Tick_Previews: PreviewProvider {
  static var previews: some View {
    Tick(tickLength: 20)
      .stroke(lineWidth: 3)
      .previewLayout(.fixed(width: 200, height: 200))
  }
}
