//
//  InfiniteMonkeyTypingContentView.swift
//  InfiniteMonkeyTyping
//
//  Created by cm0679 on 2022/7/16.
//

import SwiftUI
import Combine

struct InfiniteMonkeyTypingContentView: View {
  
  @State private var targetText = ""
  
  @State private var monkeyTyperCount = 1
  
  @State private var logText = ""
  
  @State private var textStyle = UIFont.TextStyle.body
  /// 發動「猴子」打字的 timer
  @State private var typingTimer: AnyCancellable?
  
  @State private var logs: [TypingLog] = []
  
  private var targetHint: String {
    if targetText.isEmpty {
      return "目前沒目標，請輸入目標文字在輸入框"
    }
    return "你的目標為: \(targetText)"
  }
  
  var body: some View {
    
    VStack {
      Text("無限猴子打字機")
        .font(.largeTitle)
        .padding(.top, 20)
      
      Text(targetHint)
        .lineLimit(1)
        .padding()
      
      TextField("請輸入目標", text: $targetText)
        .autocapitalization(.none)
        .padding()
        .textFieldStyle(.roundedBorder)
      
      monkeyTyperStepper
      
      monkeyActionButtons
      
      monkeyLogsAndClearLogs
      
      List(logs, id: \.self) { log in
        let eachLog = "打出的字為: \(log.typedString)"
        Text(eachLog)
      }
      Spacer()
    }
  }
  
  private var monkeyTyperStepper: some View {
    HStack {
      Stepper("猴子數: \(monkeyTyperCount)") {
        stepperIncrease()
      } onDecrement: {
        stepperDecrease()
      }
    }
    .padding()
  }
  
  private var monkeyActionButtons: some View {
    HStack {
      Button("猴子停手") {
        stopMonkeysTyping()
      }
      
      Button("叫猴子開始打字囉") {
        askMonkeysTyping()
      }
    }
    .buttonStyle(.bordered)
    .padding()
  }
  
  private var monkeyLogsAndClearLogs: some View {
    HStack {
      Spacer()
      Text("猴子的打字紀錄")
      Button {
        // TODO: - 清掉打字
      } label: {
        Text("清除打字紀錄")
      }
      .padding(.leading, 20)
      .buttonStyle(.bordered)
      Spacer()
    }
  }
  
  private func stepperIncrease() {
    monkeyTyperCount += 1
  }
  
  private func stepperDecrease() {
    if monkeyTyperCount > 1 {
      monkeyTyperCount -= 1
    }
  }
  /// 猴子開始打字囉
  private func askMonkeysTyping() {
    
    typingTimer = Timer.publish(every: 0.1, on: .main, in: .common)
      .autoconnect()
      .sink { _ in
        let typedCharacter = createRandomString()
        print("發動產生文字: \(typedCharacter)")
        // 如果想和 console 一樣，最新的在最下面，就用 append()
        let typingLog = TypingLog(typedString: typedCharacter)
        logs.insert(typingLog, at: 0)
      }
  }
  /// 叫猴子停手
  private func stopMonkeysTyping() {
    
    typingTimer?.cancel()
  }
}

extension InfiniteMonkeyTypingContentView {
  
  private var alphabet: [String] {
    let characters = "abcdefghijklmnopqrstuvwxyz"
    var chars: [String] = []
    for char in characters {
      chars.append(String(char))
    }
    return chars
  }
  
  private func createRandomString() -> String {
    
    var resultString = ""
    
    for _ in 0..<monkeyTyperCount {
      resultString += alphabet.randomElement() ?? ""
    }
    return resultString
  }
}

struct InfiniteMonkeyTypingContentView_Previews: PreviewProvider {
  static var previews: some View {
    InfiniteMonkeyTypingContentView()
  }
}
