//
//  ContentView.swift
//  ManageUIState
//
//  Created by cm0679 on 2022/8/28.
//

import SwiftUI

struct PlayButton: View {
    @Binding var isPlaying: Bool
    
    var body: some View {
        Button(action: {
            /// 加上 animation 效果
            withAnimation(.easeInOut(duration: 1)) {
                self.isPlaying.toggle()
            }
        }) {
            Image(systemName: isPlaying ? "pause.circle" : "play.circle")
                .scaleEffect(isPlaying ? 1 : 1.5)
        }
    }
}

struct PlayerView: View {
    var song: Song
    @State private var isPlaying: Bool = false
    
    var body: some View {
        VStack {
            Text(song.title)
            Text(song.showTitle)
            Text("author: \(song.author)")
            PlayButton(isPlaying: $isPlaying)
        }
        .background(isPlaying ? Color.green : Color.red) // Transitions with animation.
    }
}

struct ContentView: View {
    
    @State var song = Song(title: "Some Episode", showTitle: "Great show", author: "Tylor Swift", isFavorite: false)
    
    var body: some View {
        PlayerView(song: song)
    }
}

struct ContentView_Previews: PreviewProvider {
    
    @State static var isPlaying = false
    
    static var song: Song = Song(title: "Some Episode", showTitle: "Great show", author: "Tylor Swift", isFavorite: false)
    
    static var previews: some View {
//        ContentView()
//        PlayButton(isPlaying: $isPlaying)
//            .previewLayout(.fixed(width: 200, height: 200))
        PlayerView(song: song)
    }
}
