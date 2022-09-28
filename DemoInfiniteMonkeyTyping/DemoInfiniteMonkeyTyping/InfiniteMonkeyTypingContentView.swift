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
  /// 不管空格
  private var trimmedTarget: String {
    targetText.replacingOccurrences(of: " ", with: "")
  }
  /// 現在要打出來的「字母」index
  @State private var currentTargetIndex = 0
  /// 現在要打的「字母」
  private var targetCharacter: String? {
    /// 先簡化題目，不管大小寫
    let characters = Array(trimmedTarget.lowercased())
    
    if characters.indices.contains(currentTargetIndex) {
      return String(characters[currentTargetIndex])
    }
    
    return nil
  }
  
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
      Text("打字紀錄")
      Button {
        // TODO: - 清掉打字
      } label: {
        Text("清除打字紀錄")
      }
      .padding(.leading, 20)
      .buttonStyle(.bordered)
      
      Button {
        createPDFFile()
      } label: {
        Text("輸出 pdf")
      }
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
        if match(character: typedCharacter) {
          updateLog("\n成功比對: \(typedCharacter)\n")
          currentTargetIndex += 1
          checkIsFinish() //有符合，就停手
        }
      }
  }
  
  private func updateLog(_ string: String) {
    let typingLog = TypingLog(typedString: string)
    logs.insert(typingLog, at: 0)
  }
  
  private func checkIsFinish() {
    if trimmedTarget.count == currentTargetIndex {
      updateLog("完成比對，猴子自動停手")
      stopMonkeysTyping()
    }
  }
  
  /// 叫猴子停手
  private func stopMonkeysTyping() {
    
    typingTimer?.cancel()
  }
  
  private func match(character: String) -> Bool {
    
    guard let targetCharacter = targetCharacter else {
      return false
    }
    
    return character.contains(targetCharacter)
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

// MARK: - solution 參考自 hackingwithswift
//  https://www.hackingwithswift.com/forums/swiftui/how-to-generate-a-pdf-from-a-scrollview/5205
extension InfiniteMonkeyTypingContentView {
  private func createPDFFile() {
    
    let outputFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("TypedStringLog.pdf")
    let title = "Your Title\n"
    var text = ""
    
    logs.forEach { log in
      text += "\n\(log.typedString)"
    }
    
    let titleAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 36)]
    let textAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
    
    let formattedTitle = NSMutableAttributedString(string: title, attributes: titleAttributes)
    let formattedText = NSAttributedString(string: text, attributes: textAttributes)
    formattedTitle.append(formattedText)
    
    // 1. Create Print Formatter with your text.
    
    let formatter = UISimpleTextPrintFormatter(attributedText: formattedTitle)
    
    // 2. Add formatter with pageRender
    
    let render = UIPrintPageRenderer()
    render.addPrintFormatter(formatter, startingAtPageAt: 0)
    
    // 3. Assign paperRect and printableRect
    
    let page = CGRect(x: 0, y: 0, width: 595.2, height: 841.8) // A4, 72 dpi
    let printable = page.insetBy(dx: 0, dy: 0)
    
    render.setValue(NSValue(cgRect: page), forKey: "paperRect")
    render.setValue(NSValue(cgRect: printable), forKey: "printableRect")
    
    // 4. Create PDF context and draw
    let rect = CGRect.zero
    
    let pdfData = NSMutableData()
    UIGraphicsBeginPDFContextToData(pdfData, rect, nil)
    
    for i in 1...render.numberOfPages {
      
      UIGraphicsBeginPDFPage();
      let bounds = UIGraphicsGetPDFContextBounds()
      render.drawPage(at: i - 1, in: bounds)
    }
    
    UIGraphicsEndPDFContext();
    
    // 5. Save PDF file
    
    do {
      try pdfData.write(to: outputFileURL, options: .atomic)
      
      print("wrote PDF file with multiple pages to: \(outputFileURL.path)")
    } catch {
      
      print("Could not create PDF file: \(error.localizedDescription)")
    }
  }
}

struct InfiniteMonkeyTypingContentView_Previews: PreviewProvider {
  static var previews: some View {
    InfiniteMonkeyTypingContentView()
  }
}
