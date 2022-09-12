//
//  InfiniteMonkeyTypingContentView.swift
//  InfiniteMonkeyTyping
//
//  Created by cm0679 on 2022/7/16.
//

import SwiftUI

struct InfiniteMonkeyTypingContentView: View {
    
    @State private var targetText = ""
    
    @State private var monkeyTyperCount = 1
    
    @State private var logText = ""
    
    @State private var textStyle = UIFont.TextStyle.body
    
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
            
            Rectangle()
                .foregroundColor(.white)
                .border(Color.blue)
                .padding()
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
                // TODO: - 叫猴子停手
            }
            
            Button("叫猴子開始打字囉") {
                // TODO: - 叫猴子們開始打字
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
