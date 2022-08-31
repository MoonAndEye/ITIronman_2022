//
//  HandShape.swift
//  DemoBackwardsClock
//
//  Created by cm0679 on 2022/8/31.
//

import SwiftUI

//struct HandShape: Shape {
//
//    var spacing: CGFloat = 2
//    var spacing: CGFloat {
//        return handLength.getSpacing()
//    }
//
//    var handLength: HandLength
//
//    func path(in rect: CGRect) -> Path {
//
//        var p = Path()
//
//        p.move(to: CGPoint(x: rect.midX - spacing, y: rect.midY))
//        p.addLine(to: CGPoint(x: rect.midX, y: getHandPointY(rect: rect, handLength: handLength)))
//        p.addLine(to: CGPoint(x: rect.midX + spacing, y: rect.midY))
//
//        return p
//    }
//
//    func getHandPointY(rect: CGRect, handLength: HandLength) -> CGFloat {
//
//        let edge = min(rect.size.width, rect.size.height)
//        return edge * ( 1 - handLength.getLengthRatio())
//    }
//}

struct HandShape: Shape {
    
    var spacing: CGFloat = 2
    
    func path(in rect: CGRect) -> Path {
        
        var p = Path()

        p.move(to: CGPoint(x: rect.midX - spacing, y: rect.midY))
        p.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        p.addLine(to: CGPoint(x: rect.midX + spacing, y: rect.midY))
        
        return p
    }
}

struct HandShape_Previews: PreviewProvider {
    static var previews: some View {
        HandShape()
            .previewLayout(.fixed(width: 100, height: 100))
        HandShape()
            .fill(Color.blue)
            .previewLayout(.fixed(width: 100, height: 100))
        HandShape()
            .fill(Color.init(uiColor: .systemCyan))
            .previewLayout(.fixed(width: 100, height: 100))
    }
}
