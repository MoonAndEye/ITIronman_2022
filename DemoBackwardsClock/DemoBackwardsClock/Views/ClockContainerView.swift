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
  
  @StateObject private var clockwork: Clockwork = .init()
  
  @State private var dialColor: Color = .white
  
  @State private var isShowingGraceQuote = false
  
  @State private var isShowingGraceWikiSheet = false
  
  @State private var isShowingColorPicker = false
  
  private let graceWikiPageURL = "https://en.wikipedia.org/wiki/Grace_Hopper"
  
  private let angleUtility: AngleUtility = .init()
  
  var body: some View {
    ZStack {
      
      VStack {
        HStack {
          Spacer()
          quotePageButton
          wikiProfileButton
          settingButton
            .padding(.trailing, 5)
        }
        Spacer()
      }
      
      Group {
        ClockDialView(dialColor: $dialColor)
        HandShape(handLength: .hour)
          .fill(Color.blue)
          .rotationEffect(Angle(degrees: clockwork.hourAngle))
        HandShape(handLength: .minute)
          .fill(Color.cyan)
          .rotationEffect(Angle(degrees: clockwork.minuteAngle))
        HandShape(handLength: .second)
          .fill(Color.red)
          .rotationEffect(Angle(degrees: clockwork.secondAngle))
        Circle()
          .fill(Color.orange)
          .frame(width: 20, height: 20, alignment: .center)
      }
      .frame(width: width, height: height, alignment: .center)
      .offset(x: 0, y: -180)
      
      CounterClockwiseQuote()
        .frame(width: 250, height: 450, alignment: .center)
        .offset(x: 0, y: 150)
    }
  }
  
  private var quotePageButton: some View {
    Button {
      
      isShowingGraceQuote.toggle()
    } label: {
      Image(systemName: "quote.bubble")
        .font(.system(size: 50))
        .foregroundColor(.black)
    }
    .sheet(isPresented: $isShowingGraceQuote) {
      CounterClockwiseQuote()
    }
  }
  
  /// 將 wiki profile button 抽出
  private var wikiProfileButton: some View {
    Button {
      
      isShowingGraceWikiSheet.toggle()
    } label: {
      Image(systemName: "person.crop.circle")
        .font(.system(size: 50))
        .foregroundColor(.black)
    }
    .sheet(isPresented: $isShowingGraceWikiSheet) {
      BCWebView(urlString: graceWikiPageURL)
    }
  }
  /// 將設定按鈕抽出
  private var settingButton: some View {
    
    Button {
      
      isShowingColorPicker.toggle()
    } label: {
      Image(systemName: "gearshape.circle")
        .font(.system(size: 50))
        .foregroundColor(.black)
    }
    .sheet(isPresented: $isShowingColorPicker) {
      ColorPickerContainerView(dialColor: $dialColor)
    }
  }
}

struct ClockContainerView_Previews: PreviewProvider {
  static var previews: some View {
    ClockContainerView()
  }
}
