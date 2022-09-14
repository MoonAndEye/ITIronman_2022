//
//  ColorPickerContainerView.swift
//  DemoBackwardsClock
//
//  Created by cm0679 on 2022/9/7.
//

import SwiftUI

struct ColorPickerContainerView: View {
  
  @Binding var dialColor: Color
  
  var body: some View {
    
    ColorPicker("錶盤顏色", selection: $dialColor)
      .padding()
  }
}

struct ColorPickerContainerView_Previews: PreviewProvider {
  
  @State static var previewDialColor: Color = .white
  
  static var previews: some View {
    ColorPickerContainerView(dialColor: $previewDialColor)
  }
}

func foo() {
  
  let color: Color = .gray

  color.cgColor?.components
}
