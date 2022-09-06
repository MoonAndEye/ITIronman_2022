//
//  DemoBackwardsClockApp.swift
//  DemoBackwardsClock
//
//  Created by cm0679 on 2022/8/31.
//

import SwiftUI

@main
struct DemoBackwardsClockApp: App {
    var body: some Scene {
        WindowGroup {
          BCWebView(urlString: "https://en.wikipedia.org/wiki/Grace_Hopper")
//            ClockContainerView()
        }
    }
}
