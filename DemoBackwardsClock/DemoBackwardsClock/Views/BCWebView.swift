//
//  BCWebView.swift
//  DemoBackwardsClock
//
//  Created by cm0679 on 2022/9/6.
//

import SwiftUI
import WebKit

struct BCWebView: View {
  
  @Environment(\.dismiss) var dismiss
  
  let urlString: String
  
  var body: some View {
    
    if let url = URL(string: urlString) {
      VStack {
        HStack {
          Spacer()
          Button {
            dismiss()
          } label: {
            Image(systemName: "x.circle")
              .font(.system(size: 44))
              .tint(.black)
              .padding([.top, .trailing])
          }
        }
        WKWebViewContainer(url: url)
      }
    } else {
      URLNotCorrectView()
    }
  }
}

// 如果 URLString 給錯，就會跳 Error view
struct URLNotCorrectView: View {
  
  var body: some View {
    
    VStack {
      Image(systemName: "wifi.exclamationmark")
        .font(.system(size: 150))
        .padding()
      Text("Oops! Internet got error")
        .bold()
        .multilineTextAlignment(.center)
        .font(.system(size: 44))
    }
  }
}

struct WKWebViewContainer: UIViewRepresentable {
  
  var url: URL
  
  func makeUIView(context: Context) -> WKWebView {
    return WKWebView()
  }
  
  func updateUIView(_ webView: WKWebView, context: Context) {
    let request = URLRequest(url: url)
    webView.load(request)
  }
}

struct BCWebView_Previews: PreviewProvider {
  
  static var urlString: String {
      "https://en.wikipedia.org/wiki/Grace_Hopper"
  }
  
  static var url: URL {
      URL(string: "https://en.wikipedia.org/wiki/Grace_Hopper")!
  }
  
  static var previews: some View {
//    URLNotCorrectView()
    BCWebView(urlString: urlString)
  }
}
